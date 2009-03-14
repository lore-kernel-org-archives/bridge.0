Date: Sat, 14 Mar 2009 10:49:11 +0100
From: Jiri Pirko <jpirko@redhat.com>
Message-ID: <20090314094911.GA3455@psychotron.englab.brq.redhat.com>
References: <20090313183303.GF3436@psychotron.englab.brq.redhat.com>
	<20090313223932.50ebbd88@nehalam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090313223932.50ebbd88@nehalam>
Subject: Re: [Bridge] [PATCH] bonding: allow bond in mode balance-alb to
	work	properly in bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: fubar@us.ibm.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, bonding-devel@lists.sourceforge.net, jgarzik@pobox.com, davem@davemloft.net

Sat, Mar 14, 2009 at 06:39:32AM CET, shemminger@linux-foundation.org wrote:
>On Fri, 13 Mar 2009 19:33:04 +0100
>Jiri Pirko <jpirko@redhat.com> wrote:
>
>> Hi all.
>> 
>> This is only a draft of patch to consult. I'm aware that it should be divided
>> into multiple patches. I want to know opinion from you folks.
>> 
>> The problem is described in following bugzilla:
>> https://bugzilla.redhat.com/show_bug.cgi?id=487763
>> 
>> Basically here's what's going on. In every mode, bonding interface uses the same
>> mac address for all enslaved devices. Except for mode balance-alb. When you put
>> this kind of bond device into a bridge it will only add one of mac adresses into
>> a hash list of mac addresses, say X. This mac address is marked as local. But
>> this bonding interface also has mac address Y. Now then packet arrives with
>> destination address Y, this address is not marked as local and the packed looks
>> like it needs to be forwarded. This packet is then lost which is wrong.
>> 
>> Notice that interfaces can be added and removed from bond while it is in bridge.
>> Therefore I introduce another function pointer in struct net_device_ops -
>> ndo_check_mac_address. This function when it's implemented should check passed
>> mac address against the one set in device. I'm using this in bonding driver when
>> the bond is in mode balance-alb to walk thru all slaves and checking if any of
>> them equals passed address.
>> 
>> Then in bridge function br_handle_frame_finish() I'm using ndo_check_mac_address
>> to recognize the destination mac address as local.
>> 
>> Please look at this and tell me what you think about it.
>> 
>> Thanks
>> 
>> Jirka
>>
>
>A better and more general way to do this have the dev_set_mac_address
>function check the return of the notifier and unwind. Then any protocol
>can easily prevent address from changing.

Can you please describe this thougth a bit more? I can't understand it now...

Thanks

Jirka
