Date: Fri, 29 May 2009 10:23:44 -0700
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20090529102344.4472a3fb@nehalam>
In-Reply-To: <B927E06069952449B79EF15DB95226DF0421A58F9A@SINCHNMBX001.TechMahindra.com>
References: <B9AD81F31606254D86E238EB4A21E392072F062D@SINCHNMBX001.TechMahindra.com>
	<B927E06069952449B79EF15DB95226DF0421A58F9A@SINCHNMBX001.TechMahindra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] Help Needed On Bridge Module in Linux Kernel 2.6.23
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vijay Kumar N <vn0030410@TechMahindra.com>
Cc: bridge@linux-foundation.org, "VijayIncorporated@Gmail.com" <VijayIncorporated@Gmail.com>

On Fri, 29 May 2009 22:07:32 +0530
Vijay Kumar N <vn0030410@TechMahindra.com> wrote:

>=20
> Hi Stephen,
>             I would kindly request you to give your comments and please d=
o let me know if I=E2=80=99m going wrong anywhere.
>=20
> I=E2=80=99m using Linux Kernel 2.6.23 bridge module. I have 3 Linux Machi=
nes with 2 NIC=E2=80=99s each and would create a Bridge and add the two int=
erfaces(eth0 & eth1) on all the 3 machines to form a ring as shown in the b=
elow diagram.
> [cid:image001.gif@01C9E08E.0AED6E00]
> I don=E2=80=99t need STP to be running and I would be using only the BR_S=
TATE_FORWARDING and BR_STATE_BLOCKING only. Even when the cable is Plugged =
Out or Plugged In I have to prevent the port state changes. I would be runn=
ing my program in user space and would be controlling the port states from =
here. I also do send control packets often on the interfaces on all the nod=
es. I would be receiving these control packets in the kernel and writing it=
 to a file ( Have 2 files separate for both interfaces ). After writing to =
a file I would be sending a SIGNAL to my user space program to inform that =
a control packet was received. I use SIGUSR1 for eth0 & SIGUSR2 for eth1. I=
 have SIGUSR1 and SIGUSR2 handlers written in user space program which woul=
d be running. I use API kill_proc(PID of my process, SIGNAL_NO, &siginfo)  =
to send signals to User Space From Kernel Space. When I get signal to my Us=
er Space Program I read from that appropriate file the control packet and d=
o my processing in my program. In Kernel Space I use sys_open to create/Ope=
n a file and sys_write to write to the file with O_CREAT | O_WRONLY | O_TRU=
NC and 0777 mode.
> I set the file system to KERNEL_DS before writing to the file and after w=
riting I revert back to earlier file system state.
>=20
> Things I have changed in Linux kernel 2.6.23 bridge module to stop STP an=
d prevent the port state changes.
>=20
>=20
>  1.  Have written IOCTL to set the port states on the interface I specify.
>  2.  Have written IOCTL to send my control packets.
>  3.  Have written IOCTL to store PID of my User Space Program in Kernel.
>  4.  For sending control packets I=E2=80=99m using the same LLC API=E2=80=
=99s and NF_HOOK which STP uses.
>  5.  For receiving control packets I use the stp_bpdu_rcv(). LLC_SAP_BSPA=
N which STP uses.
>  6.  I have set the stp_state to 1 (BR_KERNEL_STP) so that I can receive =
my control packets on and stp_bpdu_rcv() via netif_recieve_skb() via LLC_SA=
P_BSPAN.
>  7.  I have commented out contents of STP bpdu sending functions, so that=
 even if it gets called no stp bpdu=E2=80=99s would flow out. When I set th=
e IP for the bridge the STP enable functions on both the interfaces [br_stp=
_enable_port() ] and the bridge [br_stp_enable_bridge() ] are called as in =
case of STP. I have commented out the code for the disable functions on bot=
h ports and bridge. So that even If I plug out or plug in the cable no stat=
e change will happen. When I add interfaces to bridge I have made changes s=
o that they would be in BR_STATE_FORWARDING.
>  8.  When a cable is plugged out I detect it using the state available in=
 /sys/class/net/ethXX/operstate and set that port to BR_STATE_BLOCKING. I w=
ould be continuously polling on this file.
>=20

It looks like you are doing same thing as user mode STP, so why not turn th=
at on and do it all in userspace.
See the rstpd program to see how that could be done.

It is too hard to debug a detailed problem. You have changed so much and ar=
e asking questions
equivalent to "I changed the wheels on my bicycle with truck tires but now =
it won't turn, please help?"
