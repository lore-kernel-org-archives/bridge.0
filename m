Return-Path: <kuba@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611975675;
 bh=1g7TFqM32r+X2G4XFMePCA3nPEQwqjwlXbzXGKcz2Fg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Fpstn8GumhB9aN2VYNzcfMHIETojhLD/lUsuuTb3UIhzrbqwoZIrnh14s4eqaFjZG
 oh3ragFnct6W0/owoHZBHl8UMx1haRVPyMSNWuV3w7bTkGJseMGTsipAS1lexGeY3z
 9j+AywEh1D2VFpQJdZSVTN7TctmGm379C7fb5Tq+0rZmIH0wGnw8nxX9BkbfTWkqw2
 E/2JsptAfTpqBqUD+Xiq1PEOKT/HEPNoIHZR8CvJZHEXuSuSTyW9q8hH4qzBbS3fpb
 t/dYSZwccpHCfjvzpxFaYikdcJpv5Gm6bvfR8AirRmvFJkZwJB0xnhnMVa+ZM+nyhf
 PPzTkGlGp4hPw==
Date: Fri, 29 Jan 2021 19:01:14 -0800
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20210129190114.3f5b6b44@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20210127205241.2864728-1-horatiu.vultur@microchip.com>
References: <20210127205241.2864728-1-horatiu.vultur@microchip.com>
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
To: rasmus.villemoes@prevas.dk, andrew@lunn.ch, Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: ivecera@redhat.com, jiri@resnulli.us, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, davem@davemloft.net, nikolay@nvidia.com, roopa@nvidia.com, Horatiu Vultur <horatiu.vultur@microchip.com>

On Wed, 27 Jan 2021 21:52:37 +0100 Horatiu Vultur wrote:
> This patch series extends MRP switchdev to allow the SW to have a better
> understanding if the HW can implement the MRP functionality or it needs
> to help the HW to run it. There are 3 cases:
> - when HW can't implement at all the functionality.
> - when HW can implement a part of the functionality but needs the SW
>   implement the rest. For example if it can't detect when it stops
>   receiving MRP Test frames but it can copy the MRP frames to CPU to
>   allow the SW to determine this.  Another example is generating the MRP
>   Test frames. If HW can't do that then the SW is used as backup.
> - when HW can implement completely the functionality.
> 
> So, initially the SW tries to offload the entire functionality in HW, if
> that fails it tries offload parts of the functionality in HW and use the
> SW as helper and if also this fails then MRP can't run on this HW.
> 
> v2:
>  - fix typos in comments and in commit messages
>  - remove some of the comments
>  - move repeated code in helper function
>  - fix issue when deleting a node when sw_backup was true

Folks who were involved in previous MRP conversations - does this look
good to you? Anyone planning to test?
