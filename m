Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 56C456108E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8BAB160C2E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ugqkr++siywh0swN5b9286pA9cKNm4n0gVMoeMdXOso=;
 b=k6+kCU7weQ3pg25j9OzluTM+hBa1YxXA6LqP1Vx0jd64QJ8TLo5IotmNhoS0o4iQw7
 kuJqLAxev3Bp8iWR/BXjDsesNGO+r8zJ+vV5wtTkseRPEH87c7jj8nv1yKYJNI8dzfNw
 mo8OzNITn0q26EG0ZMADQwbHOvUuIYopaCTiEqbY4hnwO1Dpj9MUtu+Yb4PZLuENRvBo
 JvgKW/ZjX3O9Nd3b506bNQD0lsKnobsWyFAQP5XgKrrd4m3u5uH/sDmVJ1sVj8YFx3eF
 Hrcpr1+uuLvk0vrAGZr6t0xLsilw5/gx3XazOgpWN1WnjCoc0t5Fa/rQLIPbTfe+B9Zw
 +Z2A==
Message-ID: <b5bc02cc-8c81-a4a3-8850-40cb6a4a0600@blackwall.org>
Date: Thu, 9 Feb 2023 09:23:14 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <20230209071852.613102-1-idosch@nvidia.com>
 <20230209071852.613102-4-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230209071852.613102-4-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 3/4] bridge: mcast: Move validation to
	a policy
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: petrm@nvidia.com, mlxsw@nvidia.com, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

On 2/9/23 09:18, Ido Schimmel wrote:
> Future patches are going to move parts of the bridge MDB code to the
> common rtnetlink code in preparation for VXLAN MDB support. To
> facilitate code sharing between both drivers, move the validation of the
> top level attributes in RTM_{NEW,DEL}MDB messages to a policy that will
> eventually be moved to the rtnetlink code.
> 
> Use 'NLA_NESTED' for 'MDBA_SET_ENTRY_ATTRS' instead of
> NLA_POLICY_NESTED() as this attribute is going to be validated using
> different policies in the underlying drivers.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   net/bridge/br_mdb.c | 45 +++++++++++++++++++++++++++------------------
>   1 file changed, 27 insertions(+), 18 deletions(-)
> 


Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


