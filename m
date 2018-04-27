Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=YNiVAxV0+0edeYwBMYBvet5hfOwuI5mwtsFGEkNQXAM=;
	b=HaNo7BgBE33oMaLSBlmZAl6AzqMtIsCBl/A0WXDtG29LhX1u+7PH1tHf280GmVdHKI
	oX1MKuu8itg00bPfLQJ06YFqEyJR5OwV+e3ec+Z0v1fy0nFmN0ngbwa1rp4JsFR7a2u1
	wSI58WVS5AlSD3qZgVo7oEGbcaGCtzixPnVSI=
References: <20180427151111.22099-1-idosch@mellanox.com>
	<20180427151111.22099-2-idosch@mellanox.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <1faecfc8-bf75-6ab4-cb7d-44ef27d75bf6@cumulusnetworks.com>
Date: Fri, 27 Apr 2018 18:38:18 +0300
MIME-Version: 1.0
In-Reply-To: <20180427151111.22099-2-idosch@mellanox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2 1/6] net: bridge: Publish bridge
 accessor functions
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@mellanox.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: petrm@mellanox.com, jiri@mellanox.com, mlxsw@mellanox.com, davem@davemloft.net

On 27/04/18 18:11, Ido Schimmel wrote:
> From: Petr Machata <petrm@mellanox.com>
> 
> Add a couple new functions to allow querying FDB and vlan settings of a
> bridge.
> 
> Signed-off-by: Petr Machata <petrm@mellanox.com>
> Signed-off-by: Ido Schimmel <idosch@mellanox.com>
> ---
>  include/linux/if_bridge.h | 28 ++++++++++++++++++++++++++++
>  net/bridge/br_fdb.c       | 22 ++++++++++++++++++++++
>  net/bridge/br_private.h   | 11 +++++++++++
>  net/bridge/br_vlan.c      | 39 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 100 insertions(+)
> 

Thanks! This looks good to me although the new exported helpers could've
taken both bridge or port and return the result. Usually when adding a
port-only functions we name them with nbp_ prefix instead of br_.

Anyway this can be done later since the API is internal,

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
