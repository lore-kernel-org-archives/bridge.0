Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Z2Fb3+vtJUFLAOYibiQsrogriXMJFkIlpt7gzXo5b3s=;
 b=Nfoozq3nvMm1J+m68LVpsIw8XpkqmH77WiLXMjCDym3burytz0B5uLixgTCopwdwBM
 auDMtpAY67nCdQGgxNAWmOJ5l6ZDgJ/X4r5k9Sq4Bq9ijuyBZ0vsEMD0fntd1MYXjQuy
 MpmHkobYnu5tpaoJAF72qr8D7+oZsBCi9zITEeAw+FxyalldPTV/kmURPJIKU7d/ZExo
 lgLlzIhEpSp1WpD8bVCRpIUBqjo9Eb1BgDbJ0gkvo5hFM18c21BQBwjV0XNmcuvax+Z4
 uFua8+jNXdZCUmQbyzzOqJcMK1yTFuS8Cd9lHjLrsDeHsI54wYs0aPwe9L41wqIPhQRC
 BD5A==
Date: Tue, 29 Jun 2021 21:58:22 +0300
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20210629185822.ir3vp52xkyddm3j3@skbuf>
References: <20210629140658.2510288-1-olteanv@gmail.com>
 <20210629.115213.547056454675149348.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210629.115213.547056454675149348.davem@davemloft.net>
Subject: Re: [Bridge] [PATCH v5 net-next 00/15] RX filtering in DSA
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: andrew@lunn.ch, f.fainelli@gmail.com, jiri@resnulli.us, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, vladimir.oltean@nxp.com, idosch@idosch.org, nikolay@nvidia.com, roopa@nvidia.com, kuba@kernel.org, vivien.didelot@gmail.com, tobias@waldekranz.com

On Tue, Jun 29, 2021 at 11:52:13AM -0700, David Miller wrote:
> From: Vladimir Oltean <olteanv@gmail.com>
> Date: Tue, 29 Jun 2021 17:06:43 +0300
> 
> > Changes in v5:
> > - added READ_ONCE and WRITE_ONCE for fdb->dst
> > - removed a paranoid WARN_ON in DSA
> > - added some documentation regarding how 'bridge fdb' is supposed to be
> >   used with DSA
> 
> Vlad, I applied v4, could you please send me relative fixups to v5?
> 
> Thank you.

Thanks for applying. I'm going to prepare the delta patches right now.
