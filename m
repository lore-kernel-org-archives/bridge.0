Return-Path: <David.Laight@ACULAB.COM>
From: David Laight <David.Laight@ACULAB.COM>
Date: Thu, 5 Jun 2014 13:47:30 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D17257DCF@AcuExch.aculab.com>
References: <1401965851-6449-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
	<063D6719AE5E284EB5DD2968C1650D6D17257C08@AcuExch.aculab.com>
	<539052C0.2090409@lab.ntt.co.jp>
	<063D6719AE5E284EB5DD2968C1650D6D17257D43@AcuExch.aculab.com>
	<53906B30.7080907@lab.ntt.co.jp>
In-Reply-To: <53906B30.7080907@lab.ntt.co.jp>
Content-Language: en-US
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next] bridge: Fix incorrect judgment of
	promisc
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: 'Toshiaki Makita' <makita.toshiaki@lab.ntt.co.jp>, "David S . Miller" <davem@davemloft.net>, Stephen Hemminger <stephen@networkplumber.org>
Cc: Vlad Yasevich <vyasevic@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>

From: Toshiaki Makita=20
> > A quick truth table:
> > 	auto_cnt	auto_port	set/clear
> > 		0		0	clear
> > 		0		1	clear
> > 		1		0	set
> > 		1		1	clear
> > 		2+		0/1	clear
>=20
> The last line should be set.

I've clearly not drunk enough coffee today...

I suspect the 0-1 line is impossible.
Since the check is probably for 'any other ports in 'auto' mode'.
So:
	if (auto_cnt - auto_port > 0)
(which is much the same as the original) is a good descriptive test.

	David



