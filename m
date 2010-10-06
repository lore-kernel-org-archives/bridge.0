Date: Wed, 6 Oct 2010 17:32:32 +0200
From: Rodolfo Giometti <giometti@enneenne.com>
Sender: giometti@enneenne.com
Message-ID: <20101006153232.GC24438@enneenne.com>
References: <20101005095458.GB2584@enneenne.com>
	<AANLkTim1o6SVjV76A5b2zho-HpPjeDqU8ZyAw55GNMjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <AANLkTim1o6SVjV76A5b2zho-HpPjeDqU8ZyAw55GNMjQ@mail.gmail.com>
Subject: Re: [Bridge] Invalid BPDU transmission?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Srinivas M.A." <srinivas.aji@gmail.com>
Cc: bridge@lists.linux-foundation.org, Gianpietro Germi <g.germi@selta.it>

On Tue, Oct 05, 2010 at 06:10:32PM +0530, Srinivas M.A. wrote:
> Both CONFIG and TCN BPDUs are used only in STP compatibility mode. In
> RSTP mode, the BPDUs sent in both directions are RSTP BPDUs. So they
> can be sent on the root port.
>=20
> For a description of how topology changes are handled, see the section
> titled "New Topology Change Mechanisms" in
> http://www.cisco.com/en/US/tech/tk389/tk621/technologies_white_paper09186=
a0080094cfa.shtml
>=20
> Is this causing any particular issue?

Yes. By using the following connection:

  +---------------+        +----------------------+
  | EXTRA bridge  O <----> O(eth5) bridge on test |
  +---------------+        |      (eth0) (eth1)   |
                           +--------O------O------+
                                    ^      ^
                                    |      |
                                    +------+

where =ABEXTRA bridge=BB is a rstp bridge acting as root bridge and NOT
running rstpd (but a proprietary rstp implementation), while =ABbridge
on test=BB is my bridge running rstpd.

=ABEXTRA bridge=BB sends to =ABbridge on test=BB the following BDPU:

   01 80 c2 00 00 00 00 02 3e 99 ba 1c 00 27 42 42
   03 00 00 02 02 7e 80 00 00 02 3e 99 ba 1c 00 00
   00 00 80 00 00 02 3e 99 ba 1c 80 01 00 00 14 00
   02 00 0f 00 00

and =ABbridge on test=BB replies on =ABeth5=BB, which is its root port.

Without my modification =ABbridge on test=BB is unstable, in fact the
states of eth0 and eth1 ports doesn't fit to Fwd end Blk but they
change in a strange manner and don't stabilize... also opening and
closing the loop cause more instability and the bridge takes very long
time before changing its ports states!

By adding my modification everything works well.

Ciao,

Rodolfo

--=20

GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
Freelance ICT Italia - Consulente ICT Italia - www.consulenti-ict.it
