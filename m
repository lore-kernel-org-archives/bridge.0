Return-Path: <andrew@lunn.ch>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; 
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date;
	bh=unWfdTF99Cc3d8P1xwmSPtpMgpG9Nnw6bbMKW3Vtm28=; 
	b=0zNJ7BttYnLDvghHJVOa7Kvlt5BME063s1nCoPWXttWti0mgmsESSNUX34qmJo93KKs6xrTPu6hUA562UCtOJBO8NvAq2xu795OU8eCJmyBeDIUrvlncY2SU6Lp7UmMT8lagBJG/GHqZRcgrf3PZD3ezXTOvPpiQBuu56Uf3u3c=;
Date: Sat, 31 Mar 2018 19:36:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20180331173643.GD7460@lunn.ch>
References: <cover.1522479607.git.joe@perches.com>
	<a2d52bbcdcd36c5062bd4fa175df15acd5f8cb85.1522479607.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2d52bbcdcd36c5062bd4fa175df15acd5f8cb85.1522479607.git.joe@perches.com>
Subject: Re: [Bridge] [PATCH 02/12] treewide/net: Rename eth_stp_addr to
	ether_stp_addr
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Joe Perches <joe@perches.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Vivien Didelot <vivien.didelot@savoirfairelinux.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>

On Sat, Mar 31, 2018 at 12:05:17AM -0700, Joe Perches wrote:
> --- a/net/bridge/br_device.c
> +++ b/net/bridge/br_device.c
> @@ -1,4 +1,4 @@
> -/*
> +gg/*

Hi Joe

This does not look good.

     Andrew
