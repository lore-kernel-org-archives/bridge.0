Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6825C60B10
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A2229605B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5EB9AVAb0CKe/bZtFL9Z2aSwLhDuu3g5m22iVMqNVNo=;
 b=WspXucyOJ4shf+jlfrMxHZh0eLF1c4KqgCQaD1vpHLh0OCOyovmur/BcvV+48YVObS
 DlPwI4XE05qi2pHaMUWqBDCFgxs3h8F0RAxShXj5gI6ebFmVEK529iVoi4lChcnw8VZ1
 8LWgRzZanwj15lXAPOFY/GnjkNluBysiFFKQ7DZXO1618jti3fOBv8SFcYENlVATUKwx
 y7bILplB9+esl8cEf4rVdFcgz8ljniRBGwE8ZkQp0Z3mm0gDRbKoouPUkcqB5g268vef
 ZlGfHjnW6u5vnLRG16EqZsInn7I545JJohzz3AfbeQ8sf79cVg9lB7d+lA54zu48ifM8
 f3Ug==
Message-ID: <9dc0592e-04a0-bc92-0ced-a7d43f8a0016@blackwall.org>
Date: Tue, 25 Oct 2022 14:03:48 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20221025100024.1287157-1-idosch@nvidia.com>
 <20221025100024.1287157-5-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20221025100024.1287157-5-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [RFC PATCH net-next 04/16] bridge: switchdev: Allow
 device drivers to install locked FDB entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: petrm@nvidia.com, ivecera@redhat.com, netdev@kapio-technology.com, roopa@nvidia.com, vladimir.oltean@nxp.com, edumazet@google.com, mlxsw@nvidia.com, jiri@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

On 25/10/2022 13:00, Ido Schimmel wrote:
> From: "Hans J. Schultz" <netdev@kapio-technology.com>
> 
> When the bridge is offloaded to hardware, FDB entries are learned and
> aged-out by the hardware. Some device drivers synchronize the hardware
> and software FDBs by generating switchdev events towards the bridge.
> 
> When a port is locked, the hardware must not learn autonomously, as
> otherwise any host will blindly gain authorization. Instead, the
> hardware should generate events regarding hosts that are trying to gain
> authorization and their MAC addresses should be notified by the device
> driver as locked FDB entries towards the bridge driver.
> 
> Allow device drivers to notify the bridge driver about such entries by
> extending the 'switchdev_notifier_fdb_info' structure with the 'locked'
> bit. The bit can only be set by device drivers and not by the bridge
> driver.
> 
> Prevent a locked entry from being installed if MAB is not enabled on the
> bridge port. By placing this check in the bridge driver we avoid the
> need to reflect the 'BR_PORT_MAB' flag to device drivers.
> 
> If an entry already exists in the bridge driver, reject the locked entry
> if the current entry does not have the "locked" flag set or if it points
> to a different port. The same semantics are implemented in the software
> data path.
> 
> Signed-off-by: Hans J. Schultz <netdev@kapio-technology.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
> 
> Notes:
>     Changes made by me:
>     
>      * Reword commit message.
>      * Forbid locked entries when MAB is not enabled.
>      * Forbid roaming of locked entries.
>      * Avoid setting 'locked' bit towards device drivers.
> 
>  include/net/switchdev.h   |  1 +
>  net/bridge/br.c           |  3 ++-
>  net/bridge/br_fdb.c       | 22 ++++++++++++++++++++--
>  net/bridge/br_private.h   |  2 +-
>  net/bridge/br_switchdev.c |  1 +
>  5 files changed, 25 insertions(+), 4 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


