Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D406181D4F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 15F7A81CFE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1698301365; x=1698906165;
 darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aMs/lnDVBosAB87SvMFfqFQ68LKhkyMZWsGdReytLiw=;
 b=M7kZHiOSuxkDtmPPvFXGYKp7SG4b2sD1ZSTfLphxE2/4f7jsIfVbN8Hi4PA2PmCbqj
 7+Zi1UMNXFfOL4FhnKPD6aFqMTRsoPLB60J2LWuI1k++8wbHo88i/1IGw+QJhfISU2Mv
 rmqoo7Lhj1HhliP4O+WM5jEg2673CQKjfcWXxjR/TO6viMvz1UunL/RS4JuEWBOSgB5O
 qWllKqKB2Px3nBMHP+Ue8yGRmTduzzloLOtNHhw+h56Nz+NfCd2qZccaH4cCA7hUN3US
 Zqbin26i1RqnyI0Qeqk7FqIDiiidluctbbsWNRFmn2y5yRfYc3Ed9TWlrYnoBT24GPBt
 mkUA==
Message-ID: <debc87e7-f3b9-8f46-e496-cd96b0202047@blackwall.org>
Date: Thu, 26 Oct 2023 09:22:43 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20231025123020.788710-1-idosch@nvidia.com>
 <20231025123020.788710-8-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231025123020.788710-8-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2 07/13] bridge: add MDB get uAPI
	attributes
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

On 10/25/23 15:30, Ido Schimmel wrote:
> Add MDB get attributes that correspond to the MDB set attributes used in
> RTM_NEWMDB messages. Specifically, add 'MDBA_GET_ENTRY' which will hold
> a 'struct br_mdb_entry' and 'MDBA_GET_ENTRY_ATTRS' which will hold
> 'MDBE_ATTR_*' attributes that are used as indexes (source IP and source
> VNI).
> 
> An example request will look as follows:
> 
> [ struct nlmsghdr ]
> [ struct br_port_msg ]
> [ MDBA_GET_ENTRY ]
> 	struct br_mdb_entry
> [ MDBA_GET_ENTRY_ATTRS ]
> 	[ MDBE_ATTR_SOURCE ]
> 		struct in_addr / struct in6_addr
> 	[ MDBE_ATTR_SRC_VNI ]
> 		u32
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
> 
> Notes:
>      v2:
>      * Add comment.
> 
>   include/uapi/linux/if_bridge.h | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

