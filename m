Return-Path: <kuba@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612298976;
 bh=TxCiK9MFWxmE+ojs+vuVEd7RHvf0a7ydvFCMKQDzY4w=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=gvHI9GG2gYhFGStNFewc6yQADNDHMES2D9l+feHm/lpAZ+6lZ6cYnt/HZW5XK+pqL
 u+UaAzp+dC6s23XTl8Z5+yoAfPybddjxP59FEGKhg5g+vDaz9IBtSM0WeHu1GEOTYM
 ATLZZAkAeE52s39GG/rH04OaKCp5bGK3Tpfyz9DA2m5b+X4Z8AAPigVW2ZxqkBIhTE
 w0An+ydB4Zdkl4eleFz4aCuWPGDobIKuABPQ+eIQdFzTL+iV4Q7QmFCjqgnMX70Tbe
 byyJaA6fzUZZDd2sTEqciqOkBdTwc0Ozl/fk5HD6ZViNZ1Fa35NY9VTxp7rq9QDrfA
 yAvko/bpQWEog==
Date: Tue, 2 Feb 2021 12:49:34 -0800
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20210202124934.65c90df9@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20210202200649.mc7vpgltoqxf2oni@soft-dev3.localdomain>
References: <20210127205241.2864728-1-horatiu.vultur@microchip.com>
 <20210129190114.3f5b6b44@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <9143d15f-c41d-f0ab-7be0-32d797820384@prevas.dk>
 <20210202115032.6affffdc@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20210202200649.mc7vpgltoqxf2oni@soft-dev3.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2 0/4] bridge: mrp: Extend
	br_mrp_switchdev_*
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: ivecera@redhat.com, andrew@lunn.ch, jiri@resnulli.us, Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Vladimir Oltean <vladimir.oltean@nxp.com>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, nikolay@nvidia.com, roopa@nvidia.com, davem@davemloft.net

On Tue, 2 Feb 2021 21:06:49 +0100 Horatiu Vultur wrote:
> The 02/02/2021 11:50, Jakub Kicinski wrote:
> > On Tue, 2 Feb 2021 08:40:02 +0100 Rasmus Villemoes wrote:  
> > > I am planning to test these, but it's unlikely I'll get around to it
> > > this week unfortunately.  
> > 
> > Horatiu are you okay with deferring the series until Rasmus validates?
> > Given none of this HW is upstream now (AFAIU) this is an awkward set
> > to handle. Having a confirmation from Rasmus would make us a little bit
> > more comfortable.  
> 
> It is perfectly fine for me to wait for Rasmus to validate this series.
> Also I have started to have a look how to implement the switchdev calls
> for Ocelot driver. I might have something by the end of the week, but
> lets see.

Great, thanks! Please repost once we got the confirmation.


