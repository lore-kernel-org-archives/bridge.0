Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=GxvA5GR08XX3oXnuvcFVmS/CSR0xfOx4Vk95qm7h32c=;
	b=ZyNdaYjREIL82bsC9jH+3PD39K+ch2yx3dvpf3+nDz09zk8N8NPgeK/qFTGcm3NcnX
	uXnoL5rFnjrXXzMhJVhjxHHfWw8xS2WeWkcU7Wu5BJPV+bnS9cr4W26sCj1+JAAw8uEp
	5+o0bXlwvSH5dS6aGW1KWNaYHmM1o7CkXNactc/NNUMhGf02CgnR/2OWFSepNc0k7J/O
	BGFJ9cnpp7umVFpYkIQAipUBkVIW4HHBRDJrBW+gBjVJ0I4pDKHMrSe3L4DIMxSc/85N
	9PGh1NxcNVwDEJKOiK2NuLvunT97/WX0dqruNiZwHgddZLBe7Jd+OrzFy+8E4vYFFVp1
	b7ZA==
Date: Sat, 8 Apr 2017 09:30:42 -0400
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20170408093042.20b08c5d@plumbers-lap.home.lan>
In-Reply-To: <20170408114159.12722-2-idosch@mellanox.com>
References: <20170408114159.12722-1-idosch@mellanox.com>
	<20170408114159.12722-2-idosch@mellanox.com>
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
To: idosch@mellanox.com
Cc: cera@cera.cz, mlxsw@mellanox.com, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, peter@svinota.eu, bridge@lists.linux-foundation.org, davem@davemloft.net

On Sat, 8 Apr 2017 14:41:58 +0300
<idosch@mellanox.com> wrote:

>  static void br_dev_free(struct net_device *dev)
>  {
> -	struct net_bridge *br = netdev_priv(dev);
> -
> -	free_percpu(br->stats);
>  	free_netdev(dev);
>  }
>  

Since the only thing left is free_netdev, you can now just set dev->destructor
to be free_netdev.

