Message-Id: <37EB540F-DA0D-4B5A-83F9-0019AB6E3148@gmail.com>
From: mopsosforum <mopsosforum@gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v935.3)
Date: Thu, 21 May 2009 16:36:31 +0100
Subject: [Bridge] use struct igmphdr with skb
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hello,

I work on a debien 2.6.21, and ebtables is compiled like a module.
I work on the developement of a new module for ebtables. My module  
works, it's just a new target -j TEST

My problem is when I'm in the ' static int ebt_target function',  I  
need to read some igmp information, to know the type of igmp packet  
and the group multicast.

I try something like that (in normal case I don't use the skb  
directly, i use first the function skb_copy_bits()).


static int ebt_target (struct sk_buff		**pskb,
		       unsigned int		hooknr,
		       const struct net_device	*in,
		       const struct net_device	*out,
		       const void		*data,
		       unsigned int		datalen)

{
struct sk_buff		*skb = *pskb;
printk ("igmp type :%u\n", skb->h.igmph->type);

}

I send a igmp packet to join a group
and I recieve this

        igmp type : 70

Or the different type of igmp are : 11, 12, 16, 17, 22
Normaly the good value in my case is  22 (I worked with igmp v3).

I don't undestand the response.

Then I try to see the ip of the multicast group (I send for the group  
239.255.1.4) , I recieve 0.0.24.0 .

It's really strange because if I try to see the ip address of the  
packet, it's works  (skb->h.ipiph->daddr) : 224.0.0.22


If someone have an idea of the problem ?



