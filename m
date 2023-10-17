Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B0D354060F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 07FE740554
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1697535010; x=1698139810;
 darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eqrKYPUPhr46HriX5Pvcq+Sh5npTGfsVC23Gye75nLU=;
 b=niuAUFEaO+qH5wsYeChnEpi+7dERwIqsRtRitHis0ed/V7qqwcy8FFXtHevj+TJ18d
 MaR8pwQb8J47bmjkXiSnKDkg9mfF3TJiARgKq/F5o+WVbHUDYFku0xK13543EbmQgouM
 1xUGYRkb4q8vpRGHQCGTCe2OOGKsnJtV5NfWsAsrntYQ0tSGvKDLLI8/P3j08kpFbjHy
 NNMHyWDLCgekcNG9zg3U/HeVfPs2+8/FzEQMc6kKTNaLw39ywxLowMTltVuPcBrukKRR
 Z/xLx1E0CGjdO3Gyz5YF4u9I6GJBFGfpKeUYUiMTaV5xIHfl5h1GGUEK5raZeSHqT8C3
 nXdg==
Message-ID: <40dcbbde-3e3e-fd7e-a48c-0aa2ff3bf2db@blackwall.org>
Date: Tue, 17 Oct 2023 12:30:08 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20231016131259.3302298-1-idosch@nvidia.com>
 <20231016131259.3302298-14-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231016131259.3302298-14-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 13/13] selftests: vxlan_mdb: Use MDB
 get instead of dump
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
> Test the new MDB get functionality by converting dump and grep to MDB
> get.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   tools/testing/selftests/net/test_vxlan_mdb.sh | 108 +++++++++---------
>   1 file changed, 54 insertions(+), 54 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


