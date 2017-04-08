Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=Fk/LbgDBuNFC0sVKAWadu6KiJr6AqFglBh3eHZHWvfQ=;
	b=c0LAcdin6aggCm/rbISyCsEIwpPUBtOi2N2XpVu+XuEzbquKFLfjy92EYMy1QS3Cg5
	UJlieyJ4ULO1QKq2lqKCtxq17sp3Z1AHqNe+wk27jq6mazluquAL+kwEMVAvLOrgj30a
	zbw6TT8NpOY/uGvke2ArlQGm4dA4g490SPwCfsrkrTHpCMZrbXjopNIPJpon6Hz4DJKK
	AjzSuPhcQhOHCErNqOBIHt0jpI6XDKQ5loerXbZp1cM77eDvM9HF2Wg91Pf49cjD8jO4
	wY06uTuHmoB+XWLDXqWMNfBOitQBJDgsGYEceIF7e8WcW3qnBzmA+MMYRtgoukX50ITG
	FwJA==
Date: Sat, 8 Apr 2017 10:14:01 -0400
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20170408101401.10ee916e@plumbers-lap.home.lan>
In-Reply-To: <59220a2b-aa54-844d-cda5-63a42b88f188@cumulusnetworks.com>
References: <20170408114159.12722-1-idosch@mellanox.com>
	<20170408114159.12722-2-idosch@mellanox.com>
	<20170408093042.20b08c5d@plumbers-lap.home.lan>
	<20170408134938.GA28955@splinter>
	<59220a2b-aa54-844d-cda5-63a42b88f188@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net v2 1/2] bridge: implement missing
	ndo_uninit()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: cera@cera.cz, mlxsw@mellanox.com, netdev@vger.kernel.org, peter@svinota.eu, bridge@lists.linux-foundation.org, idosch@mellanox.com, Ido Schimmel <idosch@idosch.org>, davem@davemloft.net

On Sat, 8 Apr 2017 17:05:48 +0300
Nikolay Aleksandrov <nikolay@cumulusnetworks.com> wrote:

> On 08/04/17 16:49, Ido Schimmel wrote:
> > On Sat, Apr 08, 2017 at 09:30:42AM -0400, Stephen Hemminger wrote:  
> >> On Sat, 8 Apr 2017 14:41:58 +0300
> >> <idosch@mellanox.com> wrote:
> >>  
> >>>  static void br_dev_free(struct net_device *dev)
> >>>  {
> >>> -	struct net_bridge *br = netdev_priv(dev);
> >>> -
> >>> -	free_percpu(br->stats);
> >>>  	free_netdev(dev);
> >>>  }
> >>>    
> >>
> >> Since the only thing left is free_netdev, you can now just set dev->destructor
> >> to be free_netdev.  
> > 
> > Fine.
> > 
> > Beside stylistic issues, I would appreciate comments on how this should
> > be handled. Are we reverting the patch in the Fixes line or applying
> > this patchset?
> > 
> > I prefer the first option. Then after net is merged into net-next I can
> > re-post this patchset with the requested changes.
> >   
> 
> +1
> 
> 

If this fixes the issue, then the one fix should go to stable, net and net-next.
There is no good reason to have two versions.

