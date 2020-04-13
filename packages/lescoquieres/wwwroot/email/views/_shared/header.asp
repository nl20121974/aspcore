<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <link rel="stylesheet" href="/areas/email/wwwroot/css/amazon.css" />
    <link rel="stylesheet" href="/areas/email/wwwroot/css/amazon.overwrite.css" />
    <title><%=view("title") %></title>
    <style type="text/css">
        /*added from html by nico */
        body {
            background-color: lightgray;
            margin: 0;
            font: 12px/ 16px Arial, sans-serif;
            height: 900px
        }

        .frame {
            padding: 0 20px 20px 20px;
            vertical-align: top;
            font-size: 12px;
            line-height: 16px;
            font-family: Arial, sans-serif"
        }

        .tdrow {
            vertical-align: top;
            font-size: 12px;
            line-height: 16px;
            font-family: Arial, sans-serif;
        }

        #container {
            width: 640px;
            color: rgb(51, 51, 51);
            margin: 0 auto;
            border-collapse: collapse;
        }

        #main {
            width: 100%;
            border-collapse: collapse;
        }

        #header {
            width: 100%;
            border-collapse: collapse;
        }

            #header .logo {
                width: 170px;
                padding: 18px 0 0 0;
                vertical-align: top;
                font-size: 12px;
                line-height: 16px;
                font-family: Arial, sans-serif;
            }

                #header .logo a {
                    text-decoration: none;
                    color: #bdb4aa;
                    font: 22px Arial, sans-serif;
                }

            #header .navigation {
                text-align: right;
                padding: 5px 0;
                border-bottom: 1px solid rgb(204, 204, 204);
                white-space: nowrap;
                vertical-align: top;
                font-size: 12px;
                line-height: 16px;
                font-family: Arial, sans-serif
            }

                #header .navigation a {
                    border-right: 0px solid rgb(204, 204, 204);
                    margin-right: 0px;
                    padding-right: 0px;
                    text-decoration: none;
                    color: rgb(0, 102, 153);
                    font: 12px/ 16px Arial, sans-serif;
                }

        #summary {
            width: 100%;
            border-collapse: collapse
        }

        #desiredInformation {
            width: 100%;
            border-collapse: collapse
        }

            #desiredInformation h3 {
                font-size: 18px;
                color: rgb(204, 102, 0);
                margin: 15px 0 0 0;
                font-weight: normal
            }

            #desiredInformation p {
                margin: 5px 0 0 0;
                font: 12px/ 16px Arial, sans-serif
            }

        #criticalinfo {
            width: 100%;
            border-top: 3px solid rgb(45, 55, 65);
            border-collapse: collapse
        }

            #criticalinfo td {
                font-size: 14px;
                padding: 11px 18px 18px 18px;
                background-color: rgb(239, 239, 239);
                width: 50%;
                vertical-align: top;
                line-height: 16px;
                font-family: Arial, sans-serif"
            }

            #criticalinfo p {
                margin: 2px 0 9px 0;
                font: 12px/ 16px Arial, sans-serif
            }

            #criticalinfo h2 {
                font-weight: bold;
                color: black
            }

            #criticalinfo span {
                color: #666
            }

        #closing {
            width: 100%;
            padding: 0 0 0 0;
            border-collapse: collapse
        }

            #closing p {
                padding: 0 0 20px 0;
                border-bottom: 1px solid rgb(234, 234, 234);
                margin: 10px 0 0 0;
                font: 12px/ 16px Arial, sans-serif"
            }

            #closing .signature {
                color: #bdb4aa;
                font: 22px Arial, sans-serif
            }

        h3 {
            color: #32b1b6 !important
        }
    </style>
</head>
<body>
    <table style="width: 100%; height: 800px">
        <tr>
            <td width="20%" style="width: 20%"></td>
            <td width="80%" style="width: 60%">
                <table id="container" style="align-content: center; text-align: center; background-color: white; width: 100%">
                    <tbody>
                        <tr>
                            <td class="frame">
                                <table id="main">
                                    <tbody>
                                        <tr>
                                            <td class="tdrow">
                                                <table id="header" style="width: 100%" width="100%">
                                                    <tbody>
                                                        <tr>
                                                            <td>
                                                                <img class="w3-logo" style="width: 250px !important; height: auto; display: block; margin-left: auto; margin-right: auto"
                                                                    src="https://ideadev.savati.net/areas/email/wwwroot/images/topaze_logo.png" />
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tdrow">
                                                <table id="summary">
                                                    <tbody>
                                                        <tr>
                                                            <td class="tdrow">
                                                                <h3><%=str("bonjour") & " " & view("client_nom") %></h3>
                                                                <p>
                                                                    <%=view("title") %>
                                                                </p>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                        </tr>

                                        