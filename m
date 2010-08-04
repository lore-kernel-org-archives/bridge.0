Date: Wed, 04 Aug 2010 13:31:28 +0100
From: Alex Bligh <alex@alex.org.uk>
Message-ID: <51AC42EFFBC60FE7E630D78B@Ximines.local>
In-Reply-To: <4C5953C8.2040708@free.fr>
References: <AANLkTikUczLiyxy3A5eVv7bg1XWhH-ggN1yUv2-EwLYM@mail.gmail.com>
	<4C5953C8.2040708@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: Re: [Bridge] ebtables PREROUTING -drop
Reply-To: Alex Bligh <alex@alex.org.uk>
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?UTF-8?Q?Nicolas_de_Peslo=C3=BCan?= <nicolas.2p.debian@free.fr>, ratheesh k <ratheesh.ksz@gmail.com>
Cc: Netfilter mailing list <netfilter@vger.kernel.org>, bridge@lists.linux-foundation.org, Alex Bligh <alex@alex.org.uk>



--On 4 August 2010 13:49:28 +0200 Nicolas de Peslo=C3=BCan=20
<nicolas.2p.debian@free.fr> wrote:

> Did you read http://ebtables.sourceforge.net/br_fw_ia/br_fw_ia.html and
> http://ebtables.sourceforge.net/br_fw_ia/PacketFlow.png ?

A useful improvement to those would be documenting where libpcap
(which does both input and, less well known, output) samples/injects
packets. I /think/ sampling is right on the left and injection right
on the right.

--=20
Alex Bligh
