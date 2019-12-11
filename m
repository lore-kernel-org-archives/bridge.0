Return-Path: <vivien.didelot@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:message-id:from:to:cc:subject:in-reply-to:references
 :mime-version:content-disposition:content-transfer-encoding;
 bh=hnNNPiH+0knQ/mTzZcYqFPWlCiT6PxlNTbmMZNe9cuI=;
 b=CI3y8NjAcg4RuMdoysRTliQdCeFvnlTn3p4r4x7yyAAOTht5S99FivoTPRLD2MDFgo
 yxxfP8bkP5M783hKAt0Y2mE0zBxFbKk5T+qtv//4r0NWBgGg7CbWnkFyXo76JY/3ir98
 ZaFXjOWNpKYKsviYRW5E4Mkvf7a0PxmZbCcyIL28oecPLTlC6T4BOvPZVlyOA2tc7AMQ
 2UK02IKwVa/8SuWn7sKGQNMX0q9z5btI9udvmazi4E7UBDsUnf0Cijw+m9a7qRNsZ29r
 BQJDqPg60OSZkIkh9p9o+0px5NEz9Tp4MhGVpG2Bc+rpIgZDrNTPXQoROmm3drwsvH1i
 ac2g==
Date: Tue, 10 Dec 2019 21:02:03 -0500
Message-ID: <20191210210203.GB1480973@t480s.localdomain>
From: Vivien Didelot <vivien.didelot@gmail.com>
In-Reply-To: <30e93cfb-cc2c-c484-a743-479cce19d8a9@cumulusnetworks.com>
References: <20191210212050.1470909-1-vivien.didelot@gmail.com>
 <30e93cfb-cc2c-c484-a743-479cce19d8a9@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [PATCH net-next v2] net: bridge: add STP xstats
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: netdev@vger.kernel.org, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>

Hi Nikolay,

On Tue, 10 Dec 2019 23:45:13 +0200, Nikolay Aleksandrov <nikolay@cumulusnetworks.com> wrote:
> > +	if (p) {
> > +		nla = nla_reserve_64bit(skb, BRIDGE_XSTATS_STP,
> > +					sizeof(p->stp_xstats),
> > +					BRIDGE_XSTATS_PAD);
> > +		if (!nla)
> > +			goto nla_put_failure;
> > +
> > +		memcpy(nla_data(nla), &p->stp_xstats, sizeof(p->stp_xstats));
> 
> You need to take the STP lock here to get a proper snapshot of the values.

Good catch! I see a br->multicast_lock but no br->stp_lock. Is this what
you expect?

    spin_lock_bh(&br->lock);
    memcpy(nla_data(nla), &p->stp_xstats, sizeof(p->stp_xstats));
    spin_unlock_bh(&br->lock);


Thanks,

	Vivien
