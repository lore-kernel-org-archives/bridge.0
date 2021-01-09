Return-Path: <kuba@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610229348;
 bh=eSEVYKlJZDRbP94LcaI0ZvzUvpdyptXN2y65vMluhZ4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=bnQ7NXe7kW3/nj3WGHGurkiEx1cGPKqlTUGIiPC8xNqY7T+UDyHChJvinc26NOAJc
 TgjqavvIVc6pEo7dlTbvmeN27xgoBkPdEJUSEJJ3hR5wYhupx32H5AJgW/5U+y14/g
 Sodyk6dFLk0PrtVp+cSOIHcwLKqiV/HebNGPPIk+3TTbiKa2bd/xCPBrlUjkQ9obNs
 g4mX+8pvmgWwzaDMgc0K1wkC3+MHribIRDt69zJnEuRb42bVObK3zffE2vUqXvjpTJ
 4pPxxPd3/f3xRI57kY9Nwcc4nhEqnkUS15/fY1imL8VW/h2KCXLeEhob+NZxDfevOp
 rU2QK/qPdlfOg==
Date: Sat, 9 Jan 2021 13:55:47 -0800
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20210109135547.24ab25ef@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <295b1d84-a49c-cdaa-e7fa-bbe492aa1496@infradead.org>
References: <20210108025332.52480-1-dong.menglong@zte.com.cn>
 <295b1d84-a49c-cdaa-e7fa-bbe492aa1496@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] net/bridge: fix misspellings using
 codespell tool
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Randy Dunlap <rdunlap@infradead.org>, menglong8.dong@gmail.com
Cc: Menglong Dong <dong.menglong@zte.com.cn>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, nikolay@nvidia.com, roopa@nvidia.com, davem@davemloft.net

On Thu, 7 Jan 2021 20:03:49 -0800 Randy Dunlap wrote:
> On 1/7/21 6:53 PM, menglong8.dong@gmail.com wrote:
> > From: Menglong Dong <dong.menglong@zte.com.cn>
> > 
> > Some typos are found out by codespell tool:
> > 
> > $ codespell ./net/bridge/
> > ./net/bridge/br_stp.c:604: permanant  ==> permanent
> > ./net/bridge/br_stp.c:605: persistance  ==> persistence
> > ./net/bridge/br.c:125: underlaying  ==> underlying
> > ./net/bridge/br_input.c:43: modue  ==> mode
> > ./net/bridge/br_mrp.c:828: Determin  ==> Determine
> > ./net/bridge/br_mrp.c:848: Determin  ==> Determine
> > ./net/bridge/br_mrp.c:897: Determin  ==> Determine
> > 
> > Fix typos found by codespell.
> > 
> > Signed-off-by: Menglong Dong <dong.menglong@zte.com.cn>  
> 
> LGTM. Thanks.
> 
> Acked-by: Randy Dunlap <rdunlap@infradead.org>

Applied, thanks!
