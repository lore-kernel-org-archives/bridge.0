Return-Path: <Henrik.Bjoernlund@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1602761356; x=1634297356;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=7EnMnyHDlxSioQWuwItYVnheB1FER3TeFm6RMS/adn4=;
 b=dAcjAu1Y97wQ9r7hbYoJ1/wITFVACk2+YQohuZVgZsnJySDYZQMlWR1I
 s5VmAqRGQuyTsxSI3pW8jQPb4oOyPSo9XbRDrUst2cgrX84x24A3jViXM
 H95mN3iaqmQ84cJhY0JA6+5t3aIWe5m2GnzHoeJ95cGKs5foM03a3WURJ
 ceOSJTqOoYw0PjA47DFswLKsWyBFaCbtLHFE2JFUl1gtcPIwHvrEmjYth
 nAvPyyNSTpif2zBONYRaTSAIl+pqygMbaSDsxqAwtVb00mqTyER6D7oTQ
 oKUREtsBDFr+6LL+xk5RuOyQJuBjf1UEhqUUW+BBsVP/u6hKS0TZwbABX w==;
Date: Thu, 15 Oct 2020 11:27:35 +0000
From: Henrik Bjoernlund <henrik.bjoernlund@microchip.com>
Message-ID: <20201015112735.fi2aauhyqt5ahlh2@soft-test08>
References: <20201012140428.2549163-1-henrik.bjoernlund@microchip.com>
 <20201012140428.2549163-7-henrik.bjoernlund@microchip.com>
 <20201014162655.3cbc8664@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20201014162655.3cbc8664@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
Subject: Re: [Bridge] [PATCH net-next v5 06/10] bridge: cfm: Kernel space
 implementation of CFM. CCM frame RX added.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, idosch@mellanox.com, jiri@mellanox.com, nikolay@nvidia.com, roopa@nvidia.com, Horatiu Vultur <horatiu.vultur@microchip.com>, davem@davemloft.net

Thanks for your review. Comments below.
Regards
Henrik

The 10/14/2020 16:26, Jakub Kicinski wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On Mon, 12 Oct 2020 14:04:24 +0000 Henrik Bjoernlund wrote:
> > +     /* This CCM related status is based on the latest received CCM PDU. */
> > +     u8 port_tlv_value; /* Port Status TLV value */
> > +     u8 if_tlv_value; /* Interface Status TLV value */
> > +
> > +     /* CCM has not been received for 3.25 intervals */
> > +     bool ccm_defect;
> > +
> > +     /* (RDI == 1) for last received CCM PDU */
> > +     bool rdi;
> > +
> > +     /* Indications that a CCM PDU has been seen. */
> > +     bool seen; /* CCM PDU received */
> > +     bool tlv_seen; /* CCM PDU with TLV received */
> > +     /* CCM PDU with unexpected sequence number received */
> > +     bool seq_unexp_seen;
> 
> Please consider using a u8 bitfield rather than a bunch of bools,
> if any of this structures are expected to have many instances.
> That'd save space.

I have changed as requested.

-- 
/Henrik
