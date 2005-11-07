Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Transfer-Encoding: 7bit
Message-Id: <269ECEEB-C04F-45C9-9F16-46ACF4703265@cam.ac.uk>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
From: James Blackburn <fjb31@cam.ac.uk>
Date: Mon, 7 Nov 2005 18:07:37 +0000
Sender: James Blackburn <fjb31@hermes.cam.ac.uk>
Subject: [Bridge] <kernel BUG> generated on bridge up/down & other issues
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hi,

I've been encountering some problems with bridging under linux  
2.6.12-9 (ubuntu Breezy Badger).  Apologies for the newbie-ish email:  
problem is likely a config issues, but docs appear to be sparse and I  
can't find much reference to the problem/solution on the 'net; trial  
and error really isn't working...

Am attempting to bridge an offsite network to the central network  
over the internet with vtun (2.6-4).  The configuration I have works  
intermittently.  vtun seems to work reliably - am using the -p  
(persist) option to force reconnect on disconnect.  However I have  
the following problems:

1)    On system startup vtun connects to the server correctly, but  
the bridge does not come up.  (my vtund.conf attached)
brctl show - shows the "brookf" bridge, but 'Interfaces' declares:  
"can't get port info: Function not implemented"
Restarting vtun with /etc/init.d/vtun restart brings the bridge up  
correctly. Why is this?  Currently I'm having to restart vtun on  
system startup to have it function at all.

2)    At the moment if I perform /etc/init.d/vtun restart as often as  
not there will be a kernel bug dump to the console.  It begins:
<kernel BUG at <bad filename>:21387!
	invalid operand: 0000[#1]
...  Process brctl
(For some reason it's not being logged to kern.log, but I could  
attempt to resolve that and get the whole dump if it would be useful...)
 From then on, ifconfig, hangs the console, as does sudo.  Also  
restart/halt freezes on putting down the interfaces.  This means  
that, with the persist option (as up/down are called on every connect/ 
disconnect), the box quickly becomes unusable.

I've read that there may be issues with IPv6 and kernel support.   
Although I don't use it, it's enabled by default on this kernel -  
should this be disabled?

I presume I'm doing something wrong in the vtund.conf.  Should I be  
creating and removing the bridge here, or should I create the bridge  
once when the system starts up?  How would vutn interact with the tap  
interface - should I configure it (eg tap0)  with IP 0.0.0.0 on  
startup, then specify the interface in vtun and change persist yes; - 
 > persist keep;?

If anyone can give any suggestions, I would be most grateful!

Many thanks,

James


   persist yes;
   type  ether;          # Ethernet tunnel
   up {
         program /usr/sbin/brctl "addbr brookf";
         ifconfig "%% 0.0.0.0";    #i.e. first available tap interface
         ifconfig "eth1 down";
         ifconfig "eth1 promisc";
         program /usr/sbin/brctl "addif brookf %d";
         program /usr/sbin/brctl "addif brookf eth1";
         #Bring the bridge up
         ifconfig "eth1 0.0.0.0";
         ifconfig "brookf 172.28.22.223 netmask 255.255.255.0";
   };
   down {
         ifconfig "brookf down";
         ifconfig "%% down";
         ifconfig "eth1 down";

         # Clear up bridge stuff
         program /usr/sbin/brctl "delif brookf %%";
         program /usr/sbin/brctl "delif brookf eth1";
         program /usr/sbin/brctl "delbr brookf";
   };

