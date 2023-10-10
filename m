Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 43CF96144F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 376E261376
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1696963849; x=1697568649;
 darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0gwxmekZJHXGMm97urkxFALVTBAcR9EJxHGti0iGF1E=;
 b=eFcmCUPogmgIm62WVkS4WlBAZtqe9lSMv0IwIP/NQxEBmAscMBDpml3H/84B/me46e
 QkvUBMSXeT4fpAukiyb/9asV9xanz/d8zEvwFin5pNqO1jvmYkY069Ed1Hcl8/cNXC6q
 j5fmm3fK6XlL3NVJTG/OYlpbrdQasRqJRKktSzZFzMnBjV7PvFLxHLSOQXdomyoN+NrR
 MW1bHs898PjQlcbH7FYT/2HUZ7zXvhEc3h6KlKHrKhSPQRDjUIlb4cq8RKZuzLz0jI8E
 yVZC8FhFPOwNr3qmlP0LCjE0XnReBmDyxpL8Shz4eOtmgnvgmsDWQEeAKz0rH7gBLNx/
 nGpA==
Message-ID: <4bf848f2-94a6-d941-645b-42309def1900@blackwall.org>
Date: Tue, 10 Oct 2023 21:50:42 +0300
MIME-Version: 1.0
References: <20231009100618.2911374-1-amcohen@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231009100618.2911374-1-amcohen@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 00/11] Extend VXLAN driver to support
 FDB flushing
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Amit Cohen <amcohen@nvidia.com>, netdev@vger.kernel.org
Cc: mlxsw@nvidia.com, dsahern@kernel.org, bridge@lists.linux-foundation.org, idosch@nvidia.com, linux-kselftest@vger.kernel.org, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org, davem@davemloft.net

On 10/9/23 13:06, Amit Cohen wrote:
> The merge commit 92716869375b ("Merge branch 'br-flush-filtering'") added
> support for FDB flushing in bridge driver. Extend VXLAN driver to support
> FDB flushing also. Add support for filtering by fields which are relevant
> for VXLAN FDBs:
> * Source VNI
> * Nexthop ID
> * 'router' flag
> * Destination VNI
> * Destination Port
> * Destination IP
> 
> Without this set, flush for VXLAN device fails:
> $ bridge fdb flush dev vx10
> RTNETLINK answers: Operation not supported
> 
> With this set, such flush works with the relevant arguments, for example:
> $ bridge fdb flush dev vx10 vni 5000 dst 193.2.2.1
> < flush all vx10 entries with VNI 5000 and destination IP 193.2.2.1>
> 
> Some preparations are required, handle them before adding flushing support
> in VXLAN driver. See more details in commit messages.
> 
> Patch set overview:
> Patch #1 prepares flush policy to be used by VXLAN driver
> Patches #2-#3 are preparations in VXLAN driver
> Patch #4 adds an initial support for flushing in VXLAN driver
> Patches #5-#9 add support for filtering by several attributes
> Patch #10 adds a test for FDB flush with VXLAN
> Patch #11 extends the test to check FDB flush with bridge
> 
> Amit Cohen (11):
>    net: Handle bulk delete policy in bridge driver
>    vxlan: vxlan_core: Make vxlan_flush() more generic for future use
>    vxlan: vxlan_core: Do not skip default entry in vxlan_flush() by
>      default
>    vxlan: vxlan_core: Add support for FDB flush
>    vxlan: vxlan_core: Support FDB flushing by source VNI
>    vxlan: vxlan_core: Support FDB flushing by nexthop ID
>    vxlan: vxlan_core: Support FDB flushing by destination VNI
>    vxlan: vxlan_core: Support FDB flushing by destination port
>    vxlan: vxlan_core: Support FDB flushing by destination IP
>    selftests: Add test cases for FDB flush with VXLAN device
>    selftests: fdb_flush: Add test cases for FDB flush with bridge device
> 
>   drivers/net/vxlan/vxlan_core.c           | 207 +++++-
>   include/linux/netdevice.h                |   8 +-
>   net/bridge/br_fdb.c                      |  29 +-
>   net/bridge/br_private.h                  |   3 +-
>   net/core/rtnetlink.c                     |  27 +-
>   tools/testing/selftests/net/Makefile     |   1 +
>   tools/testing/selftests/net/fdb_flush.sh | 812 +++++++++++++++++++++++
>   7 files changed, 1049 insertions(+), 38 deletions(-)
>   create mode 100755 tools/testing/selftests/net/fdb_flush.sh
> 

Nice use of the flush api. :)
The set looks good to me. For the set:
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
