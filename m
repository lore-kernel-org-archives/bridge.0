Message-ID: <405526F4.5040101@cox.net>
Date: Sun, 14 Mar 2004 20:45:56 -0700
From: Greg Morgan <drkludge@cox.net>
MIME-Version: 1.0
Subject: Re: [Bridge] Permanent after reboot
References: <018001c404f2$0ce0c3b0$6400a8c0@Wesley>
In-Reply-To: <018001c404f2$0ce0c3b0$6400a8c0@Wesley>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Wesley GDS <wesley@gds.co.za>
Cc: bridge@osdl.org

Wesley GDS wrote:
> Hi there
>  
> I was just wondering if you could help me.  I have set up a bridge 
> between my two eth cards, works fine.  The problem i have is that when i 
> reboot my PC the bridge is lost.  Is there any way i can make this 
> permanent.
>  
> I am running slackware 9.1
There are a set of initialization files or init files in Linux.  You 
will need to write a script.  All the steps that you used to create the 
bridge by hand is what will be stored in this script.   The your script 
will need to be called in runlevel 3 and runlevel 5.  This is how Linux 
systems startup.  You may want to search on System V ( as in five ) 
startup files.  Each distro puts their startup file in a different 
directory.  On Redhat systems it is in /etc/rc.d but I am not sure if 
this is the same for Slackware.

I hope this helps,
Greg

