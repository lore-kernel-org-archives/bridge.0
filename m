Date: Wed, 6 Oct 2010 18:20:13 +0200
From: Rodolfo Giometti <giometti@enneenne.com>
Sender: giometti@enneenne.com
Message-ID: <20101006162013.GP18408@enneenne.com>
References: <20101005095458.GB2584@enneenne.com>
	<AANLkTim1o6SVjV76A5b2zho-HpPjeDqU8ZyAw55GNMjQ@mail.gmail.com>
	<20101006153232.GC24438@enneenne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20101006153232.GC24438@enneenne.com>
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

On Wed, Oct 06, 2010 at 05:32:32PM +0200, Rodolfo Giometti wrote:
>=20
> =ABEXTRA bridge=BB sends to =ABbridge on test=BB the following BDPU:
>=20
>    01 80 c2 00 00 00 00 02 3e 99 ba 1c 00 27 42 42
>    03 00 00 02 02 7e 80 00 00 02 3e 99 ba 1c 00 00
>    00 00 80 00 00 02 3e 99 ba 1c 80 01 00 00 14 00
>    02 00 0f 00 00

Sorry, the correct BDPU is the following:

01 80 c2 00 00 00 00 01  f4 33 1c 54 00 27 42 42
03 00 00 02 02 7e 00 00  00 01 f4 7e a2 57 00 00
00 00 00 00 00 01 f4 7e  a2 57 83 4e 00 00 0a 00
01 00 0f 00 00

Ciao,

Rodolfo

--=20

GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
Freelance ICT Italia - Consulente ICT Italia - www.consulenti-ict.it
