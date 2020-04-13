class ckuploadadapter {
    constructor(loader) {
        // The file loader instance to use during the upload.
        this.loader = loader;
    }

    // Starts the upload process.
    upload() {
        return this.loader.file
            .then(file => new Promise((resolve, reject) => {
                this._initRequest();
                this._initListeners(resolve, reject, file);
                this._sendRequest(file);
            }));
    }

    // Aborts the upload process.
    abort() {
        if (this.xhr) {
            this.xhr.abort();
        }
    }

    // Initializes the XMLHttpRequest object using the URL passed to the constructor.
    _initRequest() {
        const xhr = this.xhr = new XMLHttpRequest();

        // Note that your request may look different. It is up to you and your editor
        // integration to choose the right communication channel. This example uses
        // a POST request with JSON as a data structure but your configuration
        // could be different.
        xhr.open('POST', '/handlers/ckeditor.asp', true);
        xhr.responseType = 'json';
    }

    // Initializes XMLHttpRequest listeners.
    _initListeners(resolve, reject, file) {
        const xhr = this.xhr;
        const loader = this.loader;
        const genericErrorText = `Couldn't upload file: ${file.name}.`;

        xhr.addEventListener('error', () => reject(genericErrorText));
        xhr.addEventListener('abort', () => reject());
        xhr.addEventListener('load', () => {
            const response = xhr.response;

            // This example assumes the XHR server's "response" object will come with
            // an "error" which has its own "message" that can be passed to reject()
            // in the upload promise.
            //
            // Your integration may handle upload errors in a different way so make sure
            // it is done properly. The reject() function must be called when the upload fails.
            if (!response || response.error) {
                return reject(response && response.error ? response.error.message : genericErrorText);
            }

            // If the upload is successful, resolve the upload promise with an object containing
            // at least the "default" URL, pointing to the image on the server.
            // This URL will be used to display the image in the content. Learn more in the
            // UploadAdapter#upload documentation.
            //var jsonresponse = JSON.parse(response);
            resolve({
                default: response.url
            });
        });

        // Upload progress when it is supported. The file loader has the #uploadTotal and #uploaded
        // properties which are used e.g. to display the upload progress bar in the editor
        // user interface.
        if (xhr.upload) {
            xhr.upload.addEventListener('progress', evt => {
                if (evt.lengthComputable) {
                    loader.uploadTotal = evt.total;
                    loader.uploaded = evt.loaded;
                }
            });
        }
    }

    // Prepares the data and sends the request.
    _sendRequest(file) {
        // Prepare the form data.
        const data = new FormData();

        data.append('upload', file);

        // Important note: This is the right place to implement security mechanisms
        // like authentication and CSRF protection. For instance, you can use
        // XMLHttpRequest.setRequestHeader() to set the request headers containing
        // the CSRF token generated earlier by your application.

        // Send the request.
        this.xhr.send(data);
    }
}

// ...

function CKUploadAdapterPlugin(editor) {
    editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
        // Configure the URL to the upload script in your back-end here!
        return new ckuploadadapter(loader);
    };
}

function useclassiceditor() {
    $('.w3-editor-void').each(function () {
        ClassicEditor
            .create($(this).get(0), {
                toolbar: []
            })
            .then(editor => {
                console.log(Array.from(editor.ui.componentFactory.names));
            })
            .catch(error => {
                console.error(error);
            });
    });
    $('.w3-editor-light').each(function () {
        ClassicEditor
            .create($(this).get(0), {
                toolbar: ['bold', 'italic', 'underline']
            })
            .then(editor => {
                console.log(Array.from(editor.ui.componentFactory.names));
            })
            .catch(error => {
                console.error(error);
            });
    });
    $('.w3-editor').each(function () {
        ClassicEditor
            .create($(this).get(0), {
                extraPlugins: [CKUploadAdapterPlugin],
                image: {
                    toolbar: ['imageTextAlternative', '|', 'imageStyle:alignLeft', 'imageStyle:full', 'imageStyle:alignRight'],
                    styles: ['full', 'alignLeft', 'alignRight']
                },
                toolbar: ['fontSize', 'bold', 'italic', 'underline', 'highlight', 'imageUpload']
            })
            .then(editor => {
                console.log(Array.from(editor.ui.componentFactory.names));
            })
            .catch(error => {
                console.error(error);
            });
    });
    $('.w3-editor-full').each(function () {
        ClassicEditor
            .create($(this).get(0), {
                extraPlugins: [CKUploadAdapterPlugin],
                image: {
                    toolbar: ['imageTextAlternative', '|', 'imageStyle:alignLeft', 'imageStyle:full', 'imageStyle:alignRight'],
                    styles: ['full', 'alignLeft', 'alignRight']
                },
                fontSize: {
                    options: [
                        'small',
                        'default',
                        'big'
                    ]
                },
                heading: {
                    options: [
                        { model: 'heading1', view: 'h1', title: 'Titre 1', class: 'ck-heading_heading1' },
                        { model: 'heading2', view: 'h2', title: 'Titre 2', class: 'ck-heading_heading2' },
                        { model: 'heading3', view: 'h3', title: 'Titre 3', class: 'ck-heading_heading3' },
                        { model: 'paragraph', view: 'p', title: 'Paragraph', class: 'ck-heading_paragraph' },
                        { model: 'span', view: 'span', title: 'Petit texte', class: 'ck-heading_span' },
                        {
                            model: 'pagebreak',
                            view: {
                                name: 'div',
                                classes: 'pagebreak'
                            },
                            title: 'Saut de page',
                            class: 'ck-heading_span',
                            converterPriority: 'high'
                        }
                    ]
                },
                highlight: {
                    options: [
                        {
                            model: 'yellowMarker',
                            class: 'marker-yellow',
                            title: 'Marqueur vert',
                            color: 'var(--ck-highlight-marker-yellow)',
                            type: 'marker'
                        },
                        {
                            model: 'greenMarker',
                            class: 'marker-green',
                            title: 'Marqueur vert',
                            color: 'var(--ck-highlight-marker-green)',
                            type: 'marker'
                        },
                        {
                            model: 'pinkMarker',
                            class: 'marker-pink',
                            title: 'Marqueur rose',
                            color: 'var(--ck-highlight-marker-pink)',
                            type: 'marker'
                        },
                        {
                            model: 'greenPen',
                            class: 'pen-green',
                            title: 'Stylo vert',
                            color: 'var(--ck-highlight-pen-green)',
                            type: 'pen'
                        },
                        {
                            model: 'redPen',
                            class: 'pen-red',
                            title: 'Stylo rouge',
                            color: 'var(--ck-highlight-pen-red)',
                            type: 'pen'
                        }
                    ]
                },
                toolbar: ['heading', '|', 'fontSize', '|', 'bold', 'italic', 'underline', 'highlight', '|', 'alignment', '|', 'bulletedList', 'numberedList', '|', 'imageUpload', 'insertTable', '|', 'undo', 'redo', '|', 'link']
            })
            .then(editor => {
                console.log(Array.from(editor.ui.componentFactory.names));
            })
            .catch(error => {
                console.error(error);
            });
    });
}