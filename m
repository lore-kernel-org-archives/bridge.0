Return-Path: <kuba@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1647322367;
 bh=XwfpXnEY7+wrg7B2csX4wE7a6rKBiz6F6P9neGxhXwA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=UBUqwwHGlWWkv2/0uGVZBkjaSlGMmZ1WBsYvT4MZVkLCkYoxa6d5Fi9HZXPaBQ6LG
 kuBdq/Lj3Jz1+RL6rtrpY5qOrORwVS4sAfA422p7vDmvApGnOTQTnRIMurdHRj0HNo
 y39TUyb4wZXrfkN500PxcuvKhPD0EwhWtZWkYsUVXta0DaSAOsfkLdRnRVTOw6K+Y8
 35oPo1Kki+E8Ex5t3TrFcFdFhZStBArIsandoLNetv6WxyFM/1v6iS3cOjTQfkQ1qt
 53YZqDGjWKPzvnUPbbaW89Kl6sx7YNTgwXf1mx40axxouESh5z+DeXl+MIjJs7xvvw
 HDhaUR5otj3Iw==
Date: Mon, 14 Mar 2022 22:32:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20220314223246.45cf8305@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20220315002543.190587-5-tobias@waldekranz.com>
References: <20220315002543.190587-1-tobias@waldekranz.com>
 <20220315002543.190587-5-tobias@waldekranz.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Petr Machata <petrm@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, Vivien Didelot <vivien.didelot@gmail.com>, Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, Cooper Lees <me@cooperlees.com>, Roopa Prabhu <roopa@nvidia.com>, Matt Johnston <matt@codeconstruct.com.au>, Vladimir Oltean <olteanv@gmail.com>, davem@davemloft.net, linux-kernel@vger.kernel.org

On Tue, 15 Mar 2022 01:25:32 +0100 Tobias Waldekranz wrote:
> Trigger a switchdev event whenever the bridge's MST mode is
> enabled/disabled. This allows constituent ports to either perform any
> required hardware config, or refuse the change if it not supported.
>=20
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>

../net/bridge/br_mst.c: In function =E2=80=98br_mst_set_enabled=E2=80=99:
../net/bridge/br_mst.c:102:16: error: variable =E2=80=98attr=E2=80=99 has i=
nitializer but incomplete type
  102 |         struct switchdev_attr attr =3D {
      |                ^~~~~~~~~~~~~~
../net/bridge/br_mst.c:103:18: error: =E2=80=98struct switchdev_attr=E2=80=
=99 has no member named =E2=80=98id=E2=80=99
  103 |                 .id =3D SWITCHDEV_ATTR_ID_BRIDGE_MST,
      |                  ^~
../net/bridge/br_mst.c:103:23: error: =E2=80=98SWITCHDEV_ATTR_ID_BRIDGE_MST=
=E2=80=99 undeclared (first use in this function)
  103 |                 .id =3D SWITCHDEV_ATTR_ID_BRIDGE_MST,
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
../net/bridge/br_mst.c:103:23: note: each undeclared identifier is reported=
 only once for each function it appears in
../net/bridge/br_mst.c:103:23: warning: excess elements in struct initializ=
er
../net/bridge/br_mst.c:103:23: note: (near initialization for =E2=80=98attr=
=E2=80=99)
../net/bridge/br_mst.c:104:18: error: =E2=80=98struct switchdev_attr=E2=80=
=99 has no member named =E2=80=98orig_dev=E2=80=99
  104 |                 .orig_dev =3D br->dev,
      |                  ^~~~~~~~
../net/bridge/br_mst.c:104:29: warning: excess elements in struct initializ=
er
  104 |                 .orig_dev =3D br->dev,
      |                             ^~
../net/bridge/br_mst.c:104:29: note: (near initialization for =E2=80=98attr=
=E2=80=99)
../net/bridge/br_mst.c:105:18: error: =E2=80=98struct switchdev_attr=E2=80=
=99 has no member named =E2=80=98u=E2=80=99
  105 |                 .u.mst =3D on,
      |                  ^
../net/bridge/br_mst.c:105:26: warning: excess elements in struct initializ=
er
  105 |                 .u.mst =3D on,
      |                          ^~
../net/bridge/br_mst.c:105:26: note: (near initialization for =E2=80=98attr=
=E2=80=99)
../net/bridge/br_mst.c:102:31: error: storage size of =E2=80=98attr=E2=80=
=99 isn=E2=80=99t known
  102 |         struct switchdev_attr attr =3D {
      |                               ^~~~
../net/bridge/br_mst.c:125:15: error: implicit declaration of function =E2=
=80=98switchdev_port_attr_set=E2=80=99; did you mean =E2=80=98br_switchdev_=
port_vlan_del=E2=80=99? [-Werror=3Dimplicit-function-declaration]
  125 |         err =3D switchdev_port_attr_set(br->dev, &attr, extack);
      |               ^~~~~~~~~~~~~~~~~~~~~~~
      |               br_switchdev_port_vlan_del
../net/bridge/br_mst.c:102:31: warning: unused variable =E2=80=98attr=E2=80=
=99 [-Wunused-variable]
  102 |         struct switchdev_attr attr =3D {
      |                               ^~~~
