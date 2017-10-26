Return-Path: <makita.toshiaki@lab.ntt.co.jp>
References: <1508950038625.54184@Dell.com>
From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Message-ID: <8ac43814-70e8-81dc-767d-3981d1547ec8@lab.ntt.co.jp>
Date: Thu, 26 Oct 2017 20:13:11 +0900
MIME-Version: 1.0
In-Reply-To: <1508950038625.54184@Dell.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] Linux Bridge Static FDB move
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Viraj.Raiyani@dell.com, bridge@lists.linux-foundation.org

On 2017/10/26 1:47, Viraj.Raiyani@dell.com wrote:
> Hi Everyone,
>=20
>=20
> Is it possible to program the FDB entry in Linux Bridge which is static,
> non-local and doesn't move to new interface=A0when the same source=A0MAC
> packet comes on a different interface=A0in the same bridge=A0=A0?

AFAIK no.
Bridge supports static fdb entries, but br_fdb_update() updates their
dst even for static entries.

>=20
>=20
> I tried=A0programming the MAC as permanent that prevents=A0the moving of =
MAC
> to a new interface in the same bridge, however it treats the MAC as
> local and doesn't do the forwarding ?

Yes, local entries will deliver frames to the bridge device itself.

--=20
Toshiaki Makita

