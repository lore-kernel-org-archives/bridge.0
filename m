Message-ID: <446C8C9E.3040504@us.checkpoint.com>
Date: Thu, 18 May 2006 08:02:54 -0700
From: Ian Schwimmer <ischwimm@us.checkpoint.com>
MIME-Version: 1.0
Subject: Re: [Bridge] VLAN translation + PVST+
References: <446BC951.2050803@us.checkpoint.com>
	<20060518143959.GB21325@tuxdriver.com>
In-Reply-To: <20060518143959.GB21325@tuxdriver.com>
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
To: "John W. Linville" <linville@tuxdriver.com>
Cc: bridge@lists.osdl.org

It is useful if the server doing the bridging is also doing something 
else, such as firewall policy enforcement.

Then, you may move hosts in and out of the "protected" VLAN simply by 
changing their port VLAN assignment. No messing with cabling, no IP 
address changes.

-Ian

John W. Linville wrote:
> On Wed, May 17, 2006 at 06:09:37PM -0700, Ian Schwimmer wrote:
>   
>> Hello, I am creating a configuration where a Redhat server running 
>> bridge-tools 0.9.5 will be bridging between different VLANs on the same 
>> physical interface (for example: a bridge consisting of eth1.100 and 
>> eth1.110). This physical interface is being connected to modern Cisco 
>> switches running PVST+.
>>     
>
> I'm curious as to how this is useful?  What is the point of having
> two VLANs on the same segment if you are just going to bridge them
> together?  Is this useful for something beyond some sort of migration?
>
> Curious,
>
> John
>   

