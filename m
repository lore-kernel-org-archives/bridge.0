Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1594118382; x=1625654382;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=vyP5ul9oKsyKcotv3JQDPSfPwCoHDgatMb5V6gzJi3U=;
 b=Zphi8+B0Jc18mVQPQ3a0SSz9Cy+hVGXZo8e8/UC76fi8WX1McN9SJm8A
 jFpj1/+75N4LTvudWxMRNs0naBbetUiZBbz/gRMEYfZsvp1m656CDJCuR
 kXqSpyvGdfVCwCoE1zL/cIeoJRqaUX09VujKRIDn2/1ce7FL2FEc7lBGp
 EG6wuKr7QoGerNOTPm31kj+y2HMEcFzOe2a+v/S+Z414PyLZoH3FfMbx0
 lcKApCm0V1UpGKmo0nbZKnKqCxuJzf6l4CWieXwwzYnMlXUPl/Lk0eqVl
 EBFZiPoGiKH3Abz9H0TyExbsabWLR9R4FsMhoBmudfRj2gQMp23ks0uT7 w==;
Date: Tue, 7 Jul 2020 12:39:39 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Message-ID: <20200707103939.basybe2a3haweki2@soft-dev3.localdomain>
References: <20200706091842.3324565-1-horatiu.vultur@microchip.com>
 <20200706091842.3324565-3-horatiu.vultur@microchip.com>
 <20200706.122748.828248704525141203.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20200706.122748.828248704525141203.davem@davemloft.net>
Subject: Re: [Bridge] [PATCH net-next 02/12] bridge: uapi: mrp: Extend MRP
 attributes for MRP interconnect
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: ivecera@redhat.com, andrew@lunn.ch, jiri@resnulli.us, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, kuba@kernel.org

The 07/06/2020 12:27, David Miller wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> From: Horatiu Vultur <horatiu.vultur@microchip.com>
> Date: Mon, 6 Jul 2020 11:18:32 +0200
> 
> > +struct br_mrp_in_state {
> > +     __u16 in_id;
> > +     __u32 in_state;
> > +};
> 
> Put the __u32 first then the __u16.
> 
> > +struct br_mrp_in_role {
> > +     __u16 in_id;
> > +     __u32 ring_id;
> > +     __u32 in_role;
> > +     __u32 i_ifindex;
> > +};
> 
> Likewise.
> 
> > +struct br_mrp_start_in_test {
> > +     __u16 in_id;
> > +     __u32 interval;
> > +     __u32 max_miss;
> > +     __u32 period;
> > +};
> 
> Likewise.
> 
> > +struct br_mrp_in_test_hdr {
> > +     __be16 id;
> > +     __u8 sa[ETH_ALEN];
> > +     __be16 port_role;
> > +     __be16 state;
> > +     __be16 transitions;
> > +     __be32 timestamp;
> > +};
> 
> Likewise.  Put the larger members first.  There is lots of unnecessary
> padding in this structure.

I will do the same here, except for the 'struct br_mrp_in_test_hdr'
because this represents the frame header for InTest frames. And this is
defined in the standard how it has to be. But I will do it for the other
structures.

> 

-- 
/Horatiu
