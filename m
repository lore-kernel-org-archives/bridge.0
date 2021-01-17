Return-Path: <kuba@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610852323;
 bh=WBZuQqQ/v6iVzAKq0bC/zQNfVZJOT1K3Ttri70N663E=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=THd3Gsy3iGk0b3GBgYX2Kwk61gBvhrAwmMue9nov2gRJp1MxsqjJ1iJDvL7qLDTIU
 reREgmqH8ccskIPDrV01qcDcY6Cwk0xstgKXJAz47xEZ26oCxk3VNzg2MYWmRyU3Rr
 cccuq8dMglUmj+xDFOnncLtiCnVgCpfhJKQgZGjrRkv0pJaKlPSyuRk5ry14PZJM3B
 69dPxiiuCNB6bbfQgZ8DqbufDrm/LF97wkaYb/N1KYQ70yW/7w7/xbYU38/m86PLFu
 0ww4xhqaCT15S08YBUIcihcKQsFiVWxsJH8OfSCye437IvmKVJ0/5jIlRcHGX5xQSQ
 PfQEJJlV8MjMA==
Date: Sat, 16 Jan 2021 18:58:42 -0800
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20210116185842.322bf3b9@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20210115044131.6039-1-dong.menglong@zte.com.cn>
References: <20210115044131.6039-1-dong.menglong@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v3 net-next] net: bridge: check vlan with
 eth_type_vlan() method
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: menglong8.dong@gmail.com
Cc: Menglong Dong <dong.menglong@zte.com.cn>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, nikolay@nvidia.com, roopa@nvidia.com, davem@davemloft.net

On Thu, 14 Jan 2021 20:41:31 -0800 menglong8.dong@gmail.com wrote:
> -	if (data[IFLA_BR_VLAN_PROTOCOL]) {
> -		switch (nla_get_be16(data[IFLA_BR_VLAN_PROTOCOL])) {
> -		case htons(ETH_P_8021Q):
> -		case htons(ETH_P_8021AD):
> -			break;
> -		default:
> -			return -EPROTONOSUPPORT;
> -		}
> +	if (data[IFLA_BR_VLAN_PROTOCOL] &&
> +	    !eth_type_vlan(nla_get_be16(data[IFLA_BR_VLAN_PROTOCOL]))) {
> +		return -EPROTONOSUPPORT;
>  	}

The curly brackets are no longer necessary here, since it's a single
line expression.
