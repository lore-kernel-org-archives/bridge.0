Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3AECF40949
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3E65440438
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1697534993; x=1698139793;
 darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7YMg9UDth1zyfm6+o4IfDJ/TtjJPGuDHzs8URdUI/W4=;
 b=GsYhVxYpby3Kuos/bkVwIlCyHvwlTr0eyK1TfW46oJzeP3wBfvh1wE5caZsWM0syaV
 ztdrwC8ifRHrA1azBXBuLN2YLGXXsJfEdEP5luoymPguAclASfNzN8a8/x6SPQ1+O5wT
 Que6G3FkCPp1gYzwTq9kqop0j2oqLEb3oFypOc31E3t5100MHvieTnkzVqVVXyRDORra
 BmkefhNfUr4hVIfS6RUZjf6B+N75QGDMhiQcrsMNiGTqfF8WfO4nJBymLPIowmLUxE+m
 YoxlvrE7VylF/5YoaiXLWoO9i7B8OSNR8FQFbnF9xY1xh/1SMfe7gTi4LtqmsKMCrLNB
 xwhA==
Message-ID: <4427a9f5-551d-db41-025e-6854c89628aa@blackwall.org>
Date: Tue, 17 Oct 2023 12:29:51 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20231016131259.3302298-1-idosch@nvidia.com>
 <20231016131259.3302298-13-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231016131259.3302298-13-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 12/13] selftests: bridge_mdb: Use MDB
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
>   .../selftests/net/forwarding/bridge_mdb.sh    | 184 +++++++-----------
>   1 file changed, 71 insertions(+), 113 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


