Return-Path: <kuba@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599426098;
 bh=AUZ/2jkw3ge8yjc1a8PiX5fWdFUU6aD/oCLWbA0734k=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=LBKh9F2hTcvYB3ARX6ZwaseOZOrUrDgCqir96n5JHPs6agXDa0p2EiDiWxSrJYuyF
 Lj3jIvfilxO4MF9xETaFZAUDQsJ1p3BnIdHLRh/pLM45iPt+FvzsX+pMiARbpjhwwH
 Nm6FfYGakfqepkH52Ur0zq9ILJDmQT0j3+DkdYj8=
Date: Sun, 6 Sep 2020 14:01:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20200906140136.77ae178d@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200905082410.2230253-7-nikolay@cumulusnetworks.com>
References: <20200905082410.2230253-1-nikolay@cumulusnetworks.com>
 <20200905082410.2230253-7-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v3 06/15] net: bridge: mcast: add
 support for group query retransmit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net, roopa@nvidia.com

On Sat,  5 Sep 2020 11:24:01 +0300 Nikolay Aleksandrov wrote:
> We need to be able to retransmit group-specific and group-and-source
> specific queries. The new timer takes care of those.

What guarantees that timer will not use pg after free? Do timer
callbacks hold the RCU read lock?
