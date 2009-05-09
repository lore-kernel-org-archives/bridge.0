Message-ID: <4A0565BB.80609@gmail.com>
Date: Sat, 09 May 2009 13:15:07 +0200
From: Jochen Hebbrecht <jochenhebbrecht@gmail.com>
MIME-Version: 1.0
References: <20090428124009.GA26387@kallisti.us>	<2e59e6970904281200u44e3ebbfga0f074dfaa78c1ab@mail.gmail.com>	<49F77248.1050800@gmail.com>	<2e59e6970904281600u42142392vb8e0eb45c4ede15c@mail.gmail.com>	<49F87D4E.4060705@gmail.com>	<20090429162651.GA9455@kallisti.us>	<49F882F9.4010100@gmail.com>	<20090429165329.GA9893@kallisti.us>	<49F8C4C3.9020504@gmail.com>	<2e59e6970904292118u71ff441ft19448f753c1b6dd9@mail.gmail.com>	<db99f77d0904292330n4c460ccbv45e60f06bfa49c4@mail.gmail.com>	<49FA1E28.5020604@free.fr>
	<49FC4764.3030707@gmail.com>	<49FDD890.1090302@free.fr>
	<49FF41C4.4090404@gmail.com>	<49FF4AF8.1050801@free.fr>
	<49FF58EC.2090902@gmail.com>	<49FFDABF.4030500@free.fr>
	<4A007103.4010501@gmail.com>	<4A00B327.6080705@free.fr>
	<4A01AE9D.3000504@gmail.com> <4A01C0FB.8040809@navigue.com>
In-Reply-To: <4A01C0FB.8040809@navigue.com>
Content-Type: multipart/alternative;
	boundary="------------030302060201060709040205"
Subject: Re: [Bridge] Ubuntu: network bridging between wireless and wired
 connection fails
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jonathan Thibault <jonathan@navigue.com>
Cc: bridge@lists.linux-foundation.org

This is a multi-part message in MIME format.
--------------030302060201060709040205
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

I tried it without no security, but no luck.

Jochen



Jonathan Thibault schreef:
> On a wrt54gs, wds is probably enabled by default when applicable to be co=
mpatible with Linksys' WET hardware.  Many vendors do not support mixing wd=
s with WPA however, limiting you to WEP for encryption.
>
> I advise you disable encryption alltogether first to see if you can get b=
ridging to work before you try with encryption.
>
> Jochen Hebbrecht wrote:
>  =20
>> Nicolas de Peslo=FCan schreef:
>>    =20
>>> That beeing said, Jonathan might be right about the need for WDS...=20
>>> Can you have a look at the AP configuration, searching for a WDS setup =

>>> ? Because if it works on Windows, without WDS (if disabled or=20
>>> unavailable on the AP), then we can assume that WDS is not required,=20
>>> even on Linux (the wifi interface is able to receive traffic for=20
>>> another MAC).
>>>
>>> If the AP is WDS enabled, then... WDS might be necessary... and=20
>>> nothing can be done if the driver for you wifi interface does not=20
>>> support it...
>>>      =20
>> http://www.linksysinfo.org/forums/showthread.php?t=3D47118
>>
>> I'm having the WRT54GS router, and the explanation above tells me how to=
=20
>> configre WDS.
>> However, when I look in my admin panel, I cannot find a tab: "WDS". I=20
>> guess my firmware is pretty old :-)
>> _______________________________________________
>> Bridge mailing list
>> Bridge@lists.linux-foundation.org
>> https://lists.linux-foundation.org/mailman/listinfo/bridge
>>    =20
>
>  =20

--------------030302060201060709040205
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
<font size="-1"><font face="Verdana">Hi Jonathan,<br>
<br>
I tried it without no security, but no luck.<br>
<br>
Jochen<br>
<br>
<br>
</font></font><br>
Jonathan Thibault schreef:
<blockquote cite="mid:4A01C0FB.8040809@navigue.com" type="cite">
  <pre wrap="">On a wrt54gs, wds is probably enabled by default when applicable to be compatible with Linksys' WET hardware.  Many vendors do not support mixing wds with WPA however, limiting you to WEP for encryption.

I advise you disable encryption alltogether first to see if you can get bridging to work before you try with encryption.

Jochen Hebbrecht wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Nicolas de Peslo&uuml;an schreef:
    </pre>
    <blockquote type="cite">
      <pre wrap="">That beeing said, Jonathan might be right about the need for WDS... 
Can you have a look at the AP configuration, searching for a WDS setup 
? Because if it works on Windows, without WDS (if disabled or 
unavailable on the AP), then we can assume that WDS is not required, 
even on Linux (the wifi interface is able to receive traffic for 
another MAC).

If the AP is WDS enabled, then... WDS might be necessary... and 
nothing can be done if the driver for you wifi interface does not 
support it...
      </pre>
    </blockquote>
    <pre wrap=""><a class="moz-txt-link-freetext" href="http://www.linksysinfo.org/forums/showthread.php?t=47118">http://www.linksysinfo.org/forums/showthread.php?t=47118</a>

I'm having the WRT54GS router, and the explanation above tells me how to 
configre WDS.
However, when I look in my admin panel, I cannot find a tab: "WDS". I 
guess my firmware is pretty old :-)
_______________________________________________
Bridge mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Bridge@lists.linux-foundation.org">Bridge@lists.linux-foundation.org</a>
<a class="moz-txt-link-freetext" href="https://lists.linux-foundation.org/mailman/listinfo/bridge">https://lists.linux-foundation.org/mailman/listinfo/bridge</a>
    </pre>
  </blockquote>
  <pre wrap=""><!---->
  </pre>
</blockquote>
</body>
</html>

--------------030302060201060709040205--
