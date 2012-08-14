Return-Path: <jiri@resnulli.us>
From: Jiri Pirko <jiri@resnulli.us>
Message-ID: <20120814072427.GA1767@minipsycho.orion>
References: <1344871635-1052-1-git-send-email-jiri@resnulli.us>
	<1344871635-1052-4-git-send-email-jiri@resnulli.us>
	<20120813160421.77a74e4e@obelix.rh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120813160421.77a74e4e@obelix.rh>
Subject: Re: [Bridge] [patch net-next 03/16] vlan: add link to upper device
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Tue, 14 Aug 2012 07:24:35 -0000
To: Flavio Leitner <fbl@redhat.com>
Cc: bridge@lists.linux-foundation.org, ursula.braun@de.ibm.com, john.r.fastabend@intel.com, edumazet@google.com, shemminger@vyatta.com, sean.hefty@intel.com, therbert@google.com, roland@kernel.org, linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org, fubar@us.ibm.com, hal.rosenstock@gmail.com, faisal.latif@intel.com, blaschka@linux.vnet.ibm.com, sony.chacko@qlogic.com, linux-driver@qlogic.com, bhutchings@solarflare.com, xiyou.wangcong@gmail.com, jitendra.kalsaria@qlogic.com, divy@chelsio.com, gregory.v.rose@intel.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kaber@trash.net, joe@perches.com, linux390@de.ibm.com, davem@davemloft.net

Mon, Aug 13, 2012 at 09:04:21PM CEST, fbl@redhat.com wrote:
>On Mon, 13 Aug 2012 17:27:02 +0200
>Jiri Pirko <jiri@resnulli.us> wrote:
>
>> Signed-off-by: Jiri Pirko <jiri@resnulli.us>
>> ---
>>  net/8021q/vlan.c |   10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>> 
>> diff --git a/net/8021q/vlan.c b/net/8021q/vlan.c
>> index 9096bcb..739665e 100644
>> --- a/net/8021q/vlan.c
>> +++ b/net/8021q/vlan.c
>> @@ -105,6 +105,8 @@ void unregister_vlan_dev(struct net_device *dev, struct list_head *head)
>>  	 */
>>  	unregister_netdevice_queue(dev, head);
>>  
>> +	netdev_upper_dev_unlink(real_dev, dev);
>> +
>>  	if (grp->nr_vlan_devs == 0)
>>  		vlan_gvrp_uninit_applicant(real_dev);
>>  
>> @@ -162,9 +164,13 @@ int register_vlan_dev(struct net_device *dev)
>>  	if (err < 0)
>>  		goto out_uninit_applicant;
>>  
>> +	err = netdev_upper_dev_link(real_dev, dev);
>> +	if (err)
>> +		goto out_uninit_applicant;
>> +
>>  	err = register_netdevice(dev);
>>  	if (err < 0)
>> -		goto out_uninit_applicant;
>> +		goto out_upper_dev_unlink;
>                ^^^^^^^^^^^^^^^^^^^^^^^^^^^
>see below:
>
>>  
>>  	/* Account for reference in struct vlan_dev_priv */
>>  	dev_hold(real_dev);
>> @@ -180,6 +186,8 @@ int register_vlan_dev(struct net_device *dev)
>>  
>>  	return 0;
>>  
>> +upper_dev_unlink:
>^^^^^^^^^^^^^^^^^^^
>should be out_upper_dev_unlink:

fixed.

Thanks!

>
>fbl
>
>> +	netdev_upper_dev_unlink(real_dev, dev);
>>  out_uninit_applicant:
>>  	if (grp->nr_vlan_devs == 0)
>>  		vlan_gvrp_uninit_applicant(real_dev);
>
