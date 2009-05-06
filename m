Message-ID: <4A01C0FB.8040809@navigue.com>
Date: Wed, 06 May 2009 12:55:23 -0400
From: Jonathan Thibault <jonathan@navigue.com>
MIME-Version: 1.0
References: <20090428124009.GA26387@kallisti.us>	<2e59e6970904281200u44e3ebbfga0f074dfaa78c1ab@mail.gmail.com>	<49F77248.1050800@gmail.com>	<2e59e6970904281600u42142392vb8e0eb45c4ede15c@mail.gmail.com>	<49F87D4E.4060705@gmail.com>	<20090429162651.GA9455@kallisti.us>	<49F882F9.4010100@gmail.com>	<20090429165329.GA9893@kallisti.us>	<49F8C4C3.9020504@gmail.com>	<2e59e6970904292118u71ff441ft19448f753c1b6dd9@mail.gmail.com>	<db99f77d0904292330n4c460ccbv45e60f06bfa49c4@mail.gmail.com>	<49FA1E28.5020604@free.fr>
	<49FC4764.3030707@gmail.com>	<49FDD890.1090302@free.fr>
	<49FF41C4.4090404@gmail.com>	<49FF4AF8.1050801@free.fr>
	<49FF58EC.2090902@gmail.com>	<49FFDABF.4030500@free.fr>
	<4A007103.4010501@gmail.com>	<4A00B327.6080705@free.fr>
	<4A01AE9D.3000504@gmail.com>
In-Reply-To: <4A01AE9D.3000504@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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
To: Jochen Hebbrecht <jochenhebbrecht@gmail.com>
Cc: bridge@lists.linux-foundation.org

On a wrt54gs, wds is probably enabled by default when applicable to be comp=
atible with Linksys' WET hardware.  Many vendors do not support mixing wds =
with WPA however, limiting you to WEP for encryption.

I advise you disable encryption alltogether first to see if you can get bri=
dging to work before you try with encryption.

Jochen Hebbrecht wrote:
>=20
> Nicolas de Peslo=FCan schreef:
>> That beeing said, Jonathan might be right about the need for WDS...=20
>> Can you have a look at the AP configuration, searching for a WDS setup=20
>> ? Because if it works on Windows, without WDS (if disabled or=20
>> unavailable on the AP), then we can assume that WDS is not required,=20
>> even on Linux (the wifi interface is able to receive traffic for=20
>> another MAC).
>>
>> If the AP is WDS enabled, then... WDS might be necessary... and=20
>> nothing can be done if the driver for you wifi interface does not=20
>> support it...
> http://www.linksysinfo.org/forums/showthread.php?t=3D47118
>=20
> I'm having the WRT54GS router, and the explanation above tells me how to =

> configre WDS.
> However, when I look in my admin panel, I cannot find a tab: "WDS". I=20
> guess my firmware is pretty old :-)
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge

