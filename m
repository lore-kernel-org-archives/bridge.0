Return-Path: <Allan.Nielsen@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1601903234; x=1633439234;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=f3Rk8sTIRBiskNiGl0kpAdCKd2pAma8USN5R7liXYu4=;
 b=mzY8iRKYywYXjMcQoV/4dgV1UUp6rSrS6ovR/yEmlAtk5tGeOseQduSq
 SEyJ5TdUX62+6G0yv7Ld5eCKrt/lhSwQJp8W6WCbMLT2Db9MmiuhaFu5M
 WEj2fo3akqm1/kY4TOWGyCVFam91hmIsEUVvxObqP7k3zjhfgDZmyQI5p
 aXXewmbDYU3NGt5sp9GhaBTpntnP0lA90YJ6mTjP+ctGoZ8mXPdrPAH2Y
 8CMK8Yq2LtLiAQltTgSuCr9IGDK3puQB9XEAEbRys4bmNi2gsSFXtwaOB
 bQHyCgX5cu4cW9X7kt65YoE7egh/+7WyItj9HdI+0L0Ac66LkLskKWAnN A==;
Date: Mon, 5 Oct 2020 15:07:12 +0200
From: "Allan W. Nielsen" <allan.nielsen@microchip.com>
Message-ID: <20201005130712.ybbgiddb7bnbkz6h@ws.localdomain>
References: <20201001103019.1342470-1-henrik.bjoernlund@microchip.com>
 <20201001103019.1342470-11-henrik.bjoernlund@microchip.com>
 <20201001124929.GM8264@nanopsycho>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
In-Reply-To: <20201001124929.GM8264@nanopsycho>
Subject: Re: [Bridge] [net-next v2 10/11] bridge: switchdev: cfm: switchdev
 interface implementation
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, jiri@mellanox.com, linux-kernel@vger.kernel.org, idosch@mellanox.com, Henrik Bjoernlund <henrik.bjoernlund@microchip.com>, nikolay@nvidia.com, roopa@nvidia.com, kuba@kernel.org, UNGLinuxDriver@microchip.com, Horatiu Vultur <horatiu.vultur@microchip.com>, davem@davemloft.net

Hi Jiri

On 01.10.2020 14:49, Jiri Pirko wrote:
>EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>
>Thu, Oct 01, 2020 at 12:30:18PM CEST, henrik.bjoernlund@microchip.com wrote:
>>This is the definition of the CFM switchdev interface.
>>
>>The interface consist of these objects:
>>    SWITCHDEV_OBJ_ID_MEP_CFM,
>>    SWITCHDEV_OBJ_ID_MEP_CONFIG_CFM,
>>    SWITCHDEV_OBJ_ID_CC_CONFIG_CFM,
>>    SWITCHDEV_OBJ_ID_CC_PEER_MEP_CFM,
>>    SWITCHDEV_OBJ_ID_CC_CCM_TX_CFM,
>>    SWITCHDEV_OBJ_ID_MEP_STATUS_CFM,
>>    SWITCHDEV_OBJ_ID_PEER_MEP_STATUS_CFM
>>
>>MEP instance add/del
>>    switchdev_port_obj_add(SWITCHDEV_OBJ_ID_MEP_CFM)
>>    switchdev_port_obj_del(SWITCHDEV_OBJ_ID_MEP_CFM)
>>
>>MEP cofigure
>>    switchdev_port_obj_add(SWITCHDEV_OBJ_ID_MEP_CONFIG_CFM)
>>
>>MEP CC cofigure
>>    switchdev_port_obj_add(SWITCHDEV_OBJ_ID_CC_CONFIG_CFM)
>>
>>Peer MEP add/del
>>    switchdev_port_obj_add(SWITCHDEV_OBJ_ID_CC_PEER_MEP_CFM)
>>    switchdev_port_obj_del(SWITCHDEV_OBJ_ID_CC_PEER_MEP_CFM)
>>
>>Start/stop CCM transmission
>>    switchdev_port_obj_add(SWITCHDEV_OBJ_ID_CC_CCM_TX_CFM)
>>
>>Get MEP status
>>       switchdev_port_obj_get(SWITCHDEV_OBJ_ID_MEP_STATUS_CFM)
>>
>>Get Peer MEP status
>>       switchdev_port_obj_get(SWITCHDEV_OBJ_ID_PEER_MEP_STATUS_CFM)
>>
>>Reviewed-by: Horatiu Vultur  <horatiu.vultur@microchip.com>
>>Signed-off-by: Henrik Bjoernlund  <henrik.bjoernlund@microchip.com>
>
>You have to submit the driver parts as a part of this patchset.
>Otherwise it is no good.
Fair enough.

With MRP we did it like this, and after Nik asked for details on what is
being offload, we thought that adding this would help.

The reason why we did not include the implementation of this interface
is that it is for a new SoC which is still not fully available which is
why we have not done the basic SwitchDev driver for it yet. But the
basic functionality clearly needs to come first.

Our preference is to continue fixing the comments we got on the pure SW
implementation and then get back to the SwitchDev offloading.

This will mean dropping the last 2 patches in the serie.

Does that work for you Jiri, and Nik?

/Allan

