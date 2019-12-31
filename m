Return-Path: <batmanustc@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=S12iGpmxlWZI7sA37G50VHKQmOLgkhqzFyTDEvCRXmg=;
 b=Cp3zPuldrcm8ws6QYmvc0z2FQLKtejathAGxeMhB+DowpEqzZSJ6IhJWGLvUxSp4e8
 sZr4oXuGtUpDhPNcoq2zanwLfpw/NLDRxRw0O+M8Dn7SYo59zowOZXafYOUI430K8Qun
 2oC1vQ+yycM59S+CVqhFYS1idiQu9SelSFGh8Mee30y3iV2NrlVnNLZoOAfXwCZeMtOR
 UtT3AQvQKYR6HL0XdFyrQccoWQMMvjcPRhRQOjVm9dN49so3lfph8ImLzXIF5LAGF1XS
 qwzplt3KySOaaDt7rxdU6tf70LXJuK45UgVnjvS/bhXEdp1nfioQSK7QQHqRVlsC1Ah8
 2WHA==
MIME-Version: 1.0
From: Simon Jones <batmanustc@gmail.com>
Date: Tue, 31 Dec 2019 19:33:24 +0800
Message-ID: <CAOE=1Z0OO+CYkZDFk06=c8b1F3VSH=nVSGU=Bu_iU6HPQxrCXw@mail.gmail.com>
Content-Type: multipart/alternative; boundary="000000000000868613059afe54e4"
Subject: [Bridge] [Linux Bridge] How to get notify of mac entry add/del of a
	Bridge ?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

--000000000000868613059afe54e4
Content-Type: text/plain; charset="UTF-8"

Hi all,

I need a feature, which sync mac addresses learned in Bridge(linux bridge).

As for routing stack, we have rtnetlink to get notify like RTM_NEWNEIGH
message.

So is there similar function in linux bridge, to get mac entry add/del
notify of a Bridge?

Thank you!

----
Simon Jones

--000000000000868613059afe54e4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi all,</div><div><br></div><div>I need a feature, wh=
ich sync mac addresses learned in Bridge(linux bridge).<br></div><div><br><=
/div><div>As for routing stack, we have=C2=A0<span style=3D"color:rgb(206,1=
45,120);background-color:rgb(30,30,30);font-family:Menlo,Monaco,&quot;Couri=
er New&quot;,monospace;font-size:12px;white-space:pre">rtnetlink</span>=C2=
=A0to get notify like RTM_NEWNEIGH message.</div><div><br></div><div>So is =
there similar function in linux bridge, to get=C2=A0mac entry add/del notif=
y of a Bridge?</div><div><br></div><div>Thank you!</div><br clear=3D"all"><=
div><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_sign=
ature"><div dir=3D"ltr"><div><div dir=3D"ltr"><div>----</div>Simon Jones</d=
iv></div></div></div></div></div>

--000000000000868613059afe54e4--
