Return-Path: <kuba@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599427924;
 bh=x7lb0UZTlIWVHwJpwneuTZolf6e4+q5mL7jqqbRFG+U=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=X0XL8nBRkYfyOYoNewrQJsLl35GLAbka8CG0Hrqf0DCajJT1rt1d0T57DAvQlQ7/y
 N8kZM8plfpUFuZp0VC5hRSBMpMYtKOCUVgxe6o2YaQA/hua2umyVNp6+E+3WStBtri
 iYUqScPl323ZMmfheBOdpwmShY8eBUXoRvj2d2hI=
Date: Sun, 6 Sep 2020 14:32:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20200906143203.011eb7ea@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <4f8ec4f0-6311-3b18-c7c4-a3a49b8d94b4@cumulusnetworks.com>
References: <20200905082410.2230253-1-nikolay@cumulusnetworks.com>
 <20200905082410.2230253-7-nikolay@cumulusnetworks.com>
 <20200906140136.77ae178d@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <4f8ec4f0-6311-3b18-c7c4-a3a49b8d94b4@cumulusnetworks.com>
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

On Mon, 7 Sep 2020 00:14:51 +0300 Nikolay Aleksandrov wrote:
> On 9/7/20 12:01 AM, Jakub Kicinski wrote:
> > On Sat,  5 Sep 2020 11:24:01 +0300 Nikolay Aleksandrov wrote:  
> >> We need to be able to retransmit group-specific and group-and-source
> >> specific queries. The new timer takes care of those.  
> > 
> > What guarantees that timer will not use pg after free? Do timer
> > callbacks hold the RCU read lock?
> 
> See the last patch, it guarantees no entry timer will be used when it's freed.

Ack.
