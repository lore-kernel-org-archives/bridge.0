Message-ID: <41EEECA5.7050409@langhofer.at>
Date: Thu, 20 Jan 2005 00:26:29 +0100
From: armin langhofer <office@langhofer.at>
MIME-Version: 1.0
Subject: Re: [Bridge] bridge with ppp0
References: <41C3675E.1010402@langhofer.at> <41EECDA0.4090909@jbaw.iba.by>
In-Reply-To: <41EECDA0.4090909@jbaw.iba.by>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

thanx for your answer. i nearly gave it up :)

i gonna try this with openvpn ... thanx for mail


regards, armin.

Bogdan B. Rudas wrote:
> You should use interfaces with same MTU size. In same situaion I made 
> OpenVPN tunel over ppp conntction with MTU 1500 (same as in ethernet 
> network)
> 
> On Sat, 18 Dec 2004 00:10:22 +0100
> armin langhofer <office@langhofer.at> wrote:
> 
>> hi there
>>
>> i found your project and tried to bridge two ppp devices.
>>
>>
>> you say (http://bridge.sourceforge.net/faq.html) that this is possible:
>>
>> ... "Linux bridging is very flexible; the LAN's can be either 
>> traditional Ethernet device's, or pseudo-devices such as PPP, VPN's or 
>> VLAN's. The only restrictions are that the devices:" ...
>>
>>
>> i tried this but got "br_add_interface: Invalid argument" when adding 
>> a ppp device to the bridge. adding an ethernet device works perfectly!
>>
>> 00:07:21 protector ~ # brctl addbr br0
>> 00:07:22 protector ~ # brctl addif br0 eth2
>> 00:07:30 protector ~ # brctl addif br0 ppp0
>> br_add_interface: Invalid argument
>>
>>
>>
>> the ppp's are done with pppd and pptpd (poptop)
>> 00:09:39 protector ~ # pppd --version
>> pppd version 2.4.2
>> 00:09:44 protector ~ # pptpd --version
>> PoPToP v1.1.4-b4
>>
>>
>> any ideas?
>>
>> best regards, armin.
>> -- 
>> armin langhofer
>> snail:  fischer von erlachstr. 29
>> snail:  a-5020 salzburg
>> phone:  +43 699 11648495
>> email:  office@langhofer.at
>> gnupg:  http://langhofer.at/pubkey.txt
>> _______________________________________________
>> Bridge mailing list
>> Bridge@lists.osdl.org
>> http://lists.osdl.org/mailman/listinfo/bridge
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Bridge mailing list
> Bridge@lists.osdl.org
> http://lists.osdl.org/mailman/listinfo/bridge
