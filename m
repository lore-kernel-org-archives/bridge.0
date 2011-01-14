Message-ID: <4D30078C.4030608@free.fr>
Date: Fri, 14 Jan 2011 09:21:32 +0100
From: =?ISO-8859-1?Q?Nicolas_de_Peslo=FCan?= <nicolas.2p.debian@free.fr>
MIME-Version: 1.0
References: <4D2F958D.2010203@navigue.com>
In-Reply-To: <4D2F958D.2010203@navigue.com>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] Tagged/untagged and gretap bridging question.
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

Le 14/01/2011 01:15, Jonathan Thibault a =E9crit :
> The goal being not to see any untagged frames coming out on the local
> network from remote locations and instead having them appear in specific
> local vlans.
>
> So at the core of my questions really is this:  Will bridging the
> untagged portion of an interface that has vlans enabled (eth0 when
> eth0.x exists) let tagged frames go through to other members of the bridg=
e?

In order to strictly control what goes into the bridge and what stay local,=
 you should have a look=20
at the ebtables command.

The following thread might also be useful:

http://www.mail-archive.com/bridge@lists.linux-foundation.org/msg01269.html

	Nicolas.
