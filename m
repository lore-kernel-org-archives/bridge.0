Date: Wed, 15 Apr 2009 10:29:24 +0200
From: Jiri Pirko <jpirko@redhat.com>
Message-ID: <20090415082924.GE21342@psychotron.englab.brq.redhat.com>
References: <20090313183303.GF3436@psychotron.englab.brq.redhat.com>
	<20090415081720.GA21342@psychotron.englab.brq.redhat.com>
	<20090415081819.GB21342@psychotron.englab.brq.redhat.com>
	<49E59A1C.9030108@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49E59A1C.9030108@cn.fujitsu.com>
Subject: Re: [Bridge] [PATCH 1/3] net: introduce a list of device
	addresses	dev_addr_list
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Li Zefan <lizf@cn.fujitsu.com>
Cc: ivecera@redhat.com, fubar@us.ibm.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, mschmidt@redhat.com, bonding-devel@lists.sourceforge.net, jgarzik@pobox.com, dada1@cosmosbay.com, davem@davemloft.net

Wed, Apr 15, 2009 at 10:26:04AM CEST, lizf@cn.fujitsu.com wrote:
>> +static int __hw_addr_add_ii(struct list_head *list, unsigned char *addr,
>> +			    int addr_len, int ignore_index)
>> +{
>> +	struct netdev_hw_addr *ha;
>> +	int i = 0;
>> +
>> +	if (addr_len > MAX_ADDR_LEN)
>> +		return -EINVAL;
>> +
>> +	rcu_read_lock();
>> +	list_for_each_entry_rcu(ha, list, list) {
>> +		if (i++ != ignore_index &&
>> +		    !memcmp(ha->addr, addr, addr_len)) {
>> +			ha->refcount++;
>> +			return 0;
>
>missing rcu_read_unlock() ?
>
Sure! Thanks...
>> +		}
>> +	}
>> +	rcu_read_unlock();
