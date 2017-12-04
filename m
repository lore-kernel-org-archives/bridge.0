Return-Path: <pneira@us.es>
Date: Mon, 4 Dec 2017 11:13:40 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
Message-ID: <20171204101340.GA7871@salvia>
References: <20171125074418.16537-1-linus.luessing@c0d3.blue>
	<20171127233008.GA1418@salvia> <20171204045335.GE3307@otheros>
	<20171204052006.GF3307@otheros>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20171204052006.GF3307@otheros>
Subject: Re: [Bridge] [PATCH net-next] bridge: ebtables: Avoid resetting
 limit rule state
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Linus =?iso-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>, "David S . Miller" <davem@davemloft.net>

On Mon, Dec 04, 2017 at 06:20:06AM +0100, Linus L=FCssing wrote:
> On Mon, Dec 04, 2017 at 05:53:35AM +0100, Linus L=FCssing wrote:
> > And so, no I do not have this patch. I looked at it now, but it
> > does not seem to have any relation with .matchinfo, does it?
>=20
> Relation between .usersize and .checkentry I ment, not
> .usersize and .matchinfo.

In your patch, info->prev comes set to a value from userspace, right?

commit 324318f0248c31be8a08984146e7e4dd7cdd091d
Author: Willem de Bruijn <willemb@google.com>
Date:   Tue May 9 16:17:37 2017 -0400

    netfilter: xtables: zero padding in data_to_user

Since that patch above, the data area is zero'ed before dumped to
userspace, so we would get a null info->prev, hence defeating the
trick your patch relies on.

Am I missing anything?
