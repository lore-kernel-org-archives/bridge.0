Return-Path: <memxor@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=AEzAoHuhPGPKCGh3cWJjJrGXHXVQzmvhoLSTyK087Xo=;
 b=djMVuKsI0YKi8jRlWCDcM3ROIbZoH//glenypM9jc7sLmeCe/EE75Y67qRrzAf3wQP
 QUobivH6WxoG9ejnNkyis1z3Jf46rdvKV7V2W3ttwBKNfuyoNAyUMIBSaurN+y6UYFmm
 NVhUjhZGlh0F4MQW6fuIZqv3iIKXwHD+7sUKTw9LzoI4OoSO74QRpxtGqMf2MIVDqMbI
 agGnOSaI6mF2rB8YbiD39ItlFrnyCv+mSU123nGp2x0E17DtbzhA9fwphSrJz4pi+THm
 sozAj6KeeguRAfAJerosUnbKNCaqMDE2tAGjnZPFKcdJtzOKZSovKzaQHvbcJtOXaEow
 fEIg==
Date: Wed, 26 Jan 2022 17:38:09 +0530
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Message-ID: <20220126120809.ihs2wko74dm4r3pi@apollo.legion>
References: <cover.1643044381.git.lorenzo@kernel.org>
 <720907692575488526f06edc2cf5c8f783777d4f.1643044381.git.lorenzo@kernel.org>
 <61553c87-a3d3-07ae-8c2f-93cf0cb52263@nvidia.com>
 <YfEwLrB6JqNpdUc0@lore-desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfEwLrB6JqNpdUc0@lore-desk>
Subject: Re: [Bridge] [RFC bpf-next 1/2] net: bridge: add unstable
 br_fdb_find_port_from_ifindex helper
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, daniel@iogearbox.net, Roopa Prabhu <roopa@nvidia.com>, netdev@vger.kernel.org, dsahern@kernel.org, toke@redhat.com, komachi.yoshiki@gmail.com, ast@kernel.org, lorenzo.bianconi@redhat.com, Ido Schimmel <idosch@idosch.org>, Nikolay Aleksandrov <nikolay@nvidia.com>, brouer@redhat.com, kuba@kernel.org, bpf@vger.kernel.org, andrii.nakryiko@gmail.com, davem@davemloft.net

On Wed, Jan 26, 2022 at 04:57:42PM IST, Lorenzo Bianconi wrote:
> > On 24/01/2022 19:20, Lorenzo Bianconi wrote:
> > > Similar to bpf_xdp_ct_lookup routine, introduce
> > > br_fdb_find_port_from_ifindex unstable helper in order to accelerate
> > > linux bridge with XDP. br_fdb_find_port_from_ifindex will perform a
> > > lookup in the associated bridge fdb table and it will return the
> > > output ifindex if the destination address is associated to a bridge
> > > port or -ENODEV for BOM traffic or if lookup fails.
> > >
> > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > ---
> > >  net/bridge/br.c         | 21 +++++++++++++
> > >  net/bridge/br_fdb.c     | 67 +++++++++++++++++++++++++++++++++++------
> > >  net/bridge/br_private.h | 12 ++++++++
> > >  3 files changed, 91 insertions(+), 9 deletions(-)
> > >
> >
> > Hi Lorenzo,
>
> Hi Nikolay,
>
> thx for the review.
>
> [...]
>
> I guess at the time I sent the series it was just in bpf-next but now it should
> be in net-next too.
> I do not think we need a unregister here.
> @Kumar: agree?
>

Yes, no need to call unregister (hence there is no unregister).

> > [...]



--
Kartikeya
