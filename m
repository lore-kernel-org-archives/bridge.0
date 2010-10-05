MIME-Version: 1.0
In-Reply-To: <20101005095458.GB2584@enneenne.com>
References: <20101005095458.GB2584@enneenne.com>
Date: Tue, 5 Oct 2010 18:10:32 +0530
Message-ID: <AANLkTim1o6SVjV76A5b2zho-HpPjeDqU8ZyAw55GNMjQ@mail.gmail.com>
From: "Srinivas M.A." <srinivas.aji@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] Invalid BPDU transmission?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Rodolfo Giometti <giometti@enneenne.com>
Cc: bridge@lists.linux-foundation.org

Both CONFIG and TCN BPDUs are used only in STP compatibility mode. In
RSTP mode, the BPDUs sent in both directions are RSTP BPDUs. So they
can be sent on the root port.

For a description of how topology changes are handled, see the section
titled "New Topology Change Mechanisms" in
http://www.cisco.com/en/US/tech/tk389/tk621/technologies_white_paper09186a0=
080094cfa.shtml

Is this causing any particular issue?

On Tue, Oct 5, 2010 at 3:24 PM, Rodolfo Giometti <giometti@enneenne.com> wr=
ote:
> Hello,
>
> in function STP_transmit_check_conditions (rstplib/transmit.c) the
> case:
>
> =A0 =A0case IDLE:
> =A0 =A0 =A0if (!port->helloWhen) return STP_hop_2_state (this,
> =A0 =A0 =A0TRANSMIT_PERIODIC);
> =A0 =A0 =A0if (!port->sendRSTP && port->newInfo &&
> =A0 =A0 =A0 =A0 =A0(port->txCount < TxHoldCount) &&
> =A0 =A0 =A0 =A0 =A0(port->role =3D=3D DesignatedPort) &&
> =A0 =A0 =A0 =A0 =A0port->helloWhen)
> =A0 =A0 =A0 =A0return STP_hop_2_state (this, TRANSMIT_CONFIG);
> =A0 =A0 =A0if (!port->sendRSTP && port->newInfo &&
> =A0 =A0 =A0 =A0 =A0(port->txCount < TxHoldCount) &&
> =A0 =A0 =A0 =A0 =A0(port->role =3D=3D RootPort) &&
> =A0 =A0 =A0 =A0 =A0port->helloWhen)
> =A0 =A0 =A0 =A0return STP_hop_2_state (this, TRANSMIT_TCN);
> =A0 =A0 =A0if (port->sendRSTP && port->newInfo &&
> =A0 =A0 =A0 =A0 =A0(port->txCount < TxHoldCount) &&
> =A0 =A0 =A0 =A0 =A0((port->role =3D=3D RootPort) || =A0 =A0 =A0 =A0 <----
> =A0 =A0 =A0 =A0 =A0 (port->role =3D=3D DesignatedPort)))
> =A0 =A0 =A0 =A0return STP_hop_2_state (this, TRANSMIT_RSTP);
> =A0 =A0 =A0break;
>
> states that a RSTP bpdu can be transmitted even throught a RootPort
> which, IMHO, is not correct... only topology change BPDU should be
> sent over the RootPort. That's why I suggest to remove the line with
> the arrow (<----).
>
> Comments? :)
>
> Ciao,
>
> Rodolfo
>
> --
>
> GNU/Linux Solutions =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0e-mail: giometti@e=
nneenne.com
> Linux Device Driver =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gi=
ometti@linux.it
> Embedded Systems =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 phone: =A0+39 34=
9 2432127
> UNIX programming =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 skype: =A0rodolf=
o.giometti
> Freelance ICT Italia - Consulente ICT Italia - www.consulenti-ict.it
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge
>
