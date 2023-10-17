Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A2DBF60E7B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E3B0360C1A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1697533596; x=1698138396;
 darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sWV3SWcCMqz8NeHwgmjx+5Uh5vS0Y0jqzWLdMkGI8SI=;
 b=b3JQlD5650cFzE3WcJUVBmOrzNMjQWYCpy0pNKczzz3lOaJQseypHv4V+ex+YfM4Hx
 018NZsppCa9cX6pkLxJTr0MQbzi+2lOerhcYzQzlNNOHXNpbwXlsGCNHY79b794FqbIv
 pxsmeCLbXOzqB2KSdmWrvFzTQzPmFw1ghZCc609pmz/aFeIqJaCFb7diXbTB9i92B3+j
 QGUbI/GaJ+30FEvM2K8X/rQ7hLdopgDzTWRP+7yrZ/pS9PenE9tA2nx+NX1HbQ1OhQgt
 LWKhG0pwkV8qKx/OTGo20t+Lnu7g5XewxMAFKx4MKgozgnHq+DR8NhEe0ITG6RHmS3+h
 rtXw==
Message-ID: <c3d6c123-229c-ede6-d859-d9b66be5e392@blackwall.org>
Date: Tue, 17 Oct 2023 12:06:29 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20231016131259.3302298-1-idosch@nvidia.com>
 <20231016131259.3302298-6-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231016131259.3302298-6-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 05/13] vxlan: mdb: Adjust function
	arguments
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: mlxsw@nvidia.com, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

On 10/16/23 16:12, Ido Schimmel wrote:
> Adjust the function's arguments and rename it to allow it to be reused
> by future call sites that only have access to 'struct
> vxlan_mdb_entry_key', but not to 'struct vxlan_mdb_config'.
> 
> No functional changes intended.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   drivers/net/vxlan/vxlan_mdb.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


