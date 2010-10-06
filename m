MIME-Version: 1.0
In-Reply-To: <20101006162013.GP18408@enneenne.com>
References: <20101005095458.GB2584@enneenne.com>
	<AANLkTim1o6SVjV76A5b2zho-HpPjeDqU8ZyAw55GNMjQ@mail.gmail.com>
	<20101006153232.GC24438@enneenne.com>
	<20101006162013.GP18408@enneenne.com>
Date: Thu, 7 Oct 2010 03:21:31 +0530
Message-ID: <AANLkTimzA_4i-16sDvpxSoudJQhRS2hocTMCWGTp8tEk@mail.gmail.com>
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
Cc: bridge@lists.linux-foundation.org, Gianpietro Germi <g.germi@selta.it>

> Sorry, the correct BDPU is the following:
>
> 01 80 c2 00 00 00 00 01 =A0f4 33 1c 54 00 27 42 42
> 03 00 00 02 02 7e 00 00 =A000 01 f4 7e a2 57 00 00
> 00 00 00 00 00 01 f4 7e =A0a2 57 83 4e 00 00 0a 00
> 01 00 0f 00 00

The 7e in 00 00 02 02 7e ... is a flags value with the proposal flag
set (mask 0x02), so it seems correct that the test bridge should
respond with agreement flag set (mask 0x40).
