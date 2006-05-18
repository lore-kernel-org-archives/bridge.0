Message-ID: <446C945C.1090300@fas.harvard.edu>
Date: Thu, 18 May 2006 11:35:56 -0400
From: Vivek Kuncham <vkuncham@fas.harvard.edu>
MIME-Version: 1.0
Subject: Re: [Bridge] VLAN translation + PVST+
References: <446BC951.2050803@us.checkpoint.com>	<20060518143959.GB21325@tuxdriver.com>
	<446C8C9E.3040504@us.checkpoint.com>
In-Reply-To: <446C8C9E.3040504@us.checkpoint.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Ian Schwimmer <ischwimm@us.checkpoint.com>
Cc: bridge@lists.osdl.org

I have no idea how I got on this list.  Would someone mind taking me 
off?  I'm not sure how to do it.

Thanks,
Vivek

On 5/18/2006 11:02 AM, Ian Schwimmer wrote:

> It is useful if the server doing the bridging is also doing something 
> else, such as firewall policy enforcement.
>
> Then, you may move hosts in and out of the "protected" VLAN simply by 
> changing their port VLAN assignment. No messing with cabling, no IP 
> address changes.
>
> -Ian
>
> John W. Linville wrote:
>
>> On Wed, May 17, 2006 at 06:09:37PM -0700, Ian Schwimmer wrote:
>>  
>>
>>> Hello, I am creating a configuration where a Redhat server running 
>>> bridge-tools 0.9.5 will be bridging between different VLANs on the 
>>> same physical interface (for example: a bridge consisting of 
>>> eth1.100 and eth1.110). This physical interface is being connected 
>>> to modern Cisco switches running PVST+.
>>>     
>>
>>
>> I'm curious as to how this is useful?  What is the point of having
>> two VLANs on the same segment if you are just going to bridge them
>> together?  Is this useful for something beyond some sort of migration?
>>
>> Curious,
>>
>> John
>>   
>
>
> _______________________________________________
> Bridge mailing list
> Bridge@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/bridge

