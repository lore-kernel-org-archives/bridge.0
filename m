Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 57F3B81248
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 31E6981000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1697533568; x=1698138368;
 darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qA7yQpTMUNBHSQCogbhz+FKzV5+XqR4AHXCW8qRlHDA=;
 b=AIvJhcEUFGQ/PkxlTHH9mnOTuXPOehCkeJ7doRiBhjw9ZEr9UTg54kUGsPjVpzd4i7
 4o3yXlJVZMU/ZxudFEvT7yXDW/wk++Jcb3KmhTj0a+FLpPJXbtpFkFnBVFGgP2bajmTI
 Xy3pS+yzOEfsKlkjAWFiJSN9wC6D0FEGm72dF0KKZQRBrde4DZ/Ttd1kqBRSr2tHdBmt
 D6N1sQdv+PTmYs7bOK1rm+bpzf/FSj+COR7BVdmqsEor2LFHiqFDogslXY5YVQDBGuc3
 j26YWuaAE7mshkEgQAVzBpomljDgR/QSaalPT6iZBVPt+mlofRNuFX0pahjKty8YQec4
 FgFw==
Message-ID: <7549f41b-2a31-238a-655e-4de2f01d1ea4@blackwall.org>
Date: Tue, 17 Oct 2023 12:06:06 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20231016131259.3302298-1-idosch@nvidia.com>
 <20231016131259.3302298-5-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231016131259.3302298-5-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 04/13] bridge: mcast: Rename MDB entry
 get function
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
> The current name is going to conflict with the upcoming net device
> operation for the MDB get operation.
> 
> Rename the function to br_mdb_entry_skb_get(). No functional changes
> intended.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   net/bridge/br_device.c    |  2 +-
>   net/bridge/br_input.c     |  2 +-
>   net/bridge/br_multicast.c |  5 +++--
>   net/bridge/br_private.h   | 10 ++++++----
>   4 files changed, 11 insertions(+), 8 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


