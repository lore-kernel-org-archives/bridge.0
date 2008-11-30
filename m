Date: Sat, 29 Nov 2008 21:17:31 -0800
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20081129211731.29c4b62d@extreme>
In-Reply-To: <BAY124-W113495D3FEB2D4035847B3A7040@phx.gbl>
References: <BAY124-W113495D3FEB2D4035847B3A7040@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] brctl mac
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Christian Salgado =?UTF-8?B?R29uesOhbGV6?= <chrisalga@hotmail.com>
Cc: bridge@linux-foundation.org

On Fri, 28 Nov 2008 13:19:03 +0100
Christian Salgado Gonz=C3=A1lez <chrisalga@hotmail.com> wrote:

>=20
> Hi Stephen,
>=20
> My name is Christian Salgado, I am using brctl in Ubuntu 8.04. I want to =
stream media from a server to a specific client.
>=20
> I have 3 pcs: server, "switch" and client. On the switch I have 3 etherne=
t devices, and, using brctl I have all together. On the client I have two e=
thernet devices, and i am using ifenslave to create a bonding interface. Wh=
en I send data from the server brctl forward it to any of both interfaces, =
or for both at the same time. I know that there are many configurations of =
ifenslave, but I would like to modify the internal arp table of brctl, to s=
elect the interface which should forward the data. Is it possible??
>=20

The bridge code tries to act like a standard Ethernet bridge.
You are trying to do something special and it is not clear.
Why do you need this?
Why can't you do it with normal connectivity?
