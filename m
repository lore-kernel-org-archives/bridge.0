Return-Path: <David.Laight@ACULAB.COM>
From: David Laight <David.Laight@ACULAB.COM>
Date: Tue, 27 May 2014 08:55:12 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1724E207@AcuExch.aculab.com>
References: <537CF5A2.3080401@pandora.be>
	<20140521.161841.1806439174351824310.davem@davemloft.net>
	<53803488.6000400@davidnewall.com>
	<20140524.134356.992924324126016022.davem@davemloft.net>
	<53815623.8020506@davidnewall.com>
In-Reply-To: <53815623.8020506@davidnewall.com>
Content-Language: en-US
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] Revert 462fb2af9788a82a534f8184abfde31574e1cfa0
 (bridge : Sanitize skb before it enters the IP stack)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: 'David Newall' <davidn@davidnewall.com>, David Miller <davem@davemloft.net>
Cc: "bdschuym@pandora.be" <bdschuym@pandora.be>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "vyasevich@gmail.com" <vyasevich@gmail.com>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "fw@strlen.de" <fw@strlen.de>, "stephen@networkplumber.org" <stephen@networkplumber.org>, "bsd@redhat.com" <bsd@redhat.com>, "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>

From: David Newall
> On 25/05/14 03:13, David Miller wrote:
> > This patch was substantially corrupted by your email client.
>=20
> We should be sending these things as mime attachments.  Having to put
> patches inline is brittle, absurd and a waste of everyone's time.  Is
> there actually anybody here who doesn't have a mime-compatible MUA?

Yes - anyone using the email client from the world's largest desktop
computer software company.

It doesn't have any method for displaying text attachments.
It has a scheme for executing attachments, for which it will use
an interpreter based on the filename extension.
(Yes - this is why it is very good at propagating viruses.)

FWIW it can send valid patches quite easily - just copy/paste from wordpad.
(Possibly after hacking the registry to allow lines longer than 72 characte=
rs.

	David



