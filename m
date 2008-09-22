Message-ID: <fed120860809221052q7f93fbd1v693b1530db0b9bc9@mail.gmail.com>
Date: Mon, 22 Sep 2008 23:22:44 +0530
From: "Srinivas M.A." <srinivas.aji@gmail.com>
In-Reply-To: <20080921225132.4fa4639f@extreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <48D6DF9D.10708@126.com> <20080921225132.4fa4639f@extreme>
Subject: Re: [Bridge] 4 ports bridge problem
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@vyatta.com>
Cc: bridge@lists.linux-foundation.org, czj <linuxdemo@126.com>

>> Every one is connected to a PC.
>>
>> eth0 =>192.168.1.11
>> eth1 => 192.168.1.22
>> eth2 => 192.168.1.33
>> eth3 => 192.168.1.44
>
> You have layer 2 and 3 confused. Are you sure you don't intend
> to route (layer 3) rather than bridging.

The IP addresses above seem to be the addresses of the connected PCs,
not what is assigned to the interfaces. The commands mentioned later
to set up the bridge seem okay.


>> but my problem is that when I used the PC(which IP is 192.168.1.11/24) to ping other PCs,
>>
>> the ping reply time from 192.168.1.22 was about 1000ms;
>> the ping reply time from 192.168.1.33 was about 0.2ms;
>> the ping reply time form 192.168.1.44 was about 300ms;

>>
>> Why? and how to configure  the 4 ethernet-ports glacier board to be a bridge or switch correctly? thanks a lot.

czj,
 The bridge seems configured okay. (You have not mentioned "ifconfig
br0 up", but you must have done that if the bridge is working at all.)
The delay could be due to many factors. Could be in the interfaces or
their drivers, or could even be delay on the part of the host
responding to ping. You could diagnose this further by taking packet
captures (with tcpdump or wireshark) while you do the pings, both on
the bridge and on the source and destination of the ping, and looking
at the packet times in these.
