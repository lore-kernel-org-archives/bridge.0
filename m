Return-Path: <tobias@waldekranz.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=waldekranz-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version:content-transfer-encoding;
 bh=w7BDs3bl+/ZPNAYyg8MK8EHAzhqEJFCQVGbId855EFw=;
 b=UNKIKiXT8QfonLayJTWbx/cxsyCrYGovzyCMkmOQ0WbbLDyVWoFc+Uk1YSJdQ1ErVj
 NSZ65OYFwoBxTx37iTZxofhPtQYuTz0inW2ISH8BrEsIVKWupQ1V/0v2AOTqnkzOqHIW
 MVzHAKTAj6L5LAFrRjVFItdVTexCKpxRKzLUb91eMO3QhpYWVcExxhjIB3WbJnai2fTU
 qfuNwPew+1Y3t6NU7MAANItoNNKZRVoZY9NnXqRDDEl6dp6M2w5ktTXMJ6Fflzyk/u8n
 bGm8okMa05EECvOosBzkbLV4oB43ONkLUH1EODsepFAU/yZWqBY7ocKkvqsrQZA8Ubbx
 k16w==
From: Tobias Waldekranz <tobias@waldekranz.com>
In-Reply-To: <20220314223246.45cf8305@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20220315002543.190587-1-tobias@waldekranz.com>
 <20220315002543.190587-5-tobias@waldekranz.com>
 <20220314223246.45cf8305@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Date: Tue, 15 Mar 2022 23:28:40 +0100
Message-ID: <87bky6lujr.fsf@waldekranz.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH v4 net-next 04/15] net: bridge: mst: Notify
 switchdev drivers of MST mode changes
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Petr Machata <petrm@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, Vivien Didelot <vivien.didelot@gmail.com>, Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, Cooper Lees <me@cooperlees.com>, Roopa Prabhu <roopa@nvidia.com>, Matt Johnston <matt@codeconstruct.com.au>, Vladimir Oltean <olteanv@gmail.com>, davem@davemloft.net, linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 22:32, Jakub Kicinski <kuba@kernel.org> wrote:
> On Tue, 15 Mar 2022 01:25:32 +0100 Tobias Waldekranz wrote:
>> Trigger a switchdev event whenever the bridge's MST mode is
>> enabled/disabled. This allows constituent ports to either perform any
>> required hardware config, or refuse the change if it not supported.
>>=20
>> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
>
> ../net/bridge/br_mst.c: In function =E2=80=98br_mst_set_enabled=E2=80=99:
> ../net/bridge/br_mst.c:102:16: error: variable =E2=80=98attr=E2=80=99 has=
 initializer but incomplete type
>   102 |         struct switchdev_attr attr =3D {
>       |                ^~~~~~~~~~~~~~
> ../net/bridge/br_mst.c:103:18: error: =E2=80=98struct switchdev_attr=E2=
=80=99 has no member named =E2=80=98id=E2=80=99
>   103 |                 .id =3D SWITCHDEV_ATTR_ID_BRIDGE_MST,
>       |                  ^~
> ../net/bridge/br_mst.c:103:23: error: =E2=80=98SWITCHDEV_ATTR_ID_BRIDGE_M=
ST=E2=80=99 undeclared (first use in this function)
>   103 |                 .id =3D SWITCHDEV_ATTR_ID_BRIDGE_MST,
>       |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../net/bridge/br_mst.c:103:23: note: each undeclared identifier is report=
ed only once for each function it appears in
> ../net/bridge/br_mst.c:103:23: warning: excess elements in struct initial=
izer
> ../net/bridge/br_mst.c:103:23: note: (near initialization for =E2=80=98at=
tr=E2=80=99)
> ../net/bridge/br_mst.c:104:18: error: =E2=80=98struct switchdev_attr=E2=
=80=99 has no member named =E2=80=98orig_dev=E2=80=99
>   104 |                 .orig_dev =3D br->dev,
>       |                  ^~~~~~~~
> ../net/bridge/br_mst.c:104:29: warning: excess elements in struct initial=
izer
>   104 |                 .orig_dev =3D br->dev,
>       |                             ^~
> ../net/bridge/br_mst.c:104:29: note: (near initialization for =E2=80=98at=
tr=E2=80=99)
> ../net/bridge/br_mst.c:105:18: error: =E2=80=98struct switchdev_attr=E2=
=80=99 has no member named =E2=80=98u=E2=80=99
>   105 |                 .u.mst =3D on,
>       |                  ^
> ../net/bridge/br_mst.c:105:26: warning: excess elements in struct initial=
izer
>   105 |                 .u.mst =3D on,
>       |                          ^~
> ../net/bridge/br_mst.c:105:26: note: (near initialization for =E2=80=98at=
tr=E2=80=99)
> ../net/bridge/br_mst.c:102:31: error: storage size of =E2=80=98attr=E2=80=
=99 isn=E2=80=99t known
>   102 |         struct switchdev_attr attr =3D {
>       |                               ^~~~
> ../net/bridge/br_mst.c:125:15: error: implicit declaration of function =
=E2=80=98switchdev_port_attr_set=E2=80=99; did you mean =E2=80=98br_switchd=
ev_port_vlan_del=E2=80=99? [-Werror=3Dimplicit-function-declaration]
>   125 |         err =3D switchdev_port_attr_set(br->dev, &attr, extack);
>       |               ^~~~~~~~~~~~~~~~~~~~~~~
>       |               br_switchdev_port_vlan_del
> ../net/bridge/br_mst.c:102:31: warning: unused variable =E2=80=98attr=E2=
=80=99 [-Wunused-variable]
>   102 |         struct switchdev_attr attr =3D {
>       |                               ^~~~

Sorry about that. Forgot to run the incremental build after the
rebase. Will be fixed in v5.
