Message-ID: <45B7E603.8050705@pacbell.net>
Date: Wed, 24 Jan 2007 15:04:35 -0800
From: Michael Boutte <mboutte@pacbell.net>
MIME-Version: 1.0
References: <45B797C1.50803@pacbell.net> <20070124133052.267727eb@freekitty>
In-Reply-To: <20070124133052.267727eb@freekitty>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] LAN-WAN Bridging Problem
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: bridge@osdl.org

Stephen,
Thank you for your prompt response.
I had actually tried setting the forward delay to 0 before and many 
other commands - none worked. There seem to be only two ways to get the 
bridge to work again. 1 (not good) is to reboot the unit the bridge is 
on, and 2 (easy, but I don't know how to do it automatically) is to 
issue the command "ifconfig eth0 up". You do not need to issue a down 
command first either. I also tried the command "ifconfig br0 up" and 
that does not work.

When the bridge is not working I can still access those items connected 
to eth0 from the bridge's ipaddress using telnet. Per your howto 
instructions the bridge takes on the eth0 ipaddress, which was set to 0 
so that I have a way to telnet in. This tells me that the ethernet port 
is working, so it appears that the link across the bridges two 
interfaces is what is not re-instated.

Just for grins, here is my script section that builds the bridge.

        # if you don't set these addresses to zero it won't work
        /sbin/ifconfig hdlc0 ipaddr 0.0.0.0
        /sbin/ifconfig eth0 ipaddr 0.0.0.0
        # Create a bridge device
        /sbin/brctl addbr br0
        /sbin/brctl addif br0 hdlc0    # Add the hdlc port to the bridge
        /sbin/brctl addif br0 eth0    # Adding eth0 last causes the 
bridge to take its MAC

        # Now the bridge takes on the original IP address of eth0
        /sbin/ifconfig br0 ipaddr $FEC_IPADDR

        #Bring it up and were done
        /sbin/ifconfig br0 up
        if [ -n "$GATEWAY" ]; then
            echo -n "Setting br0 Gateway Address from eth0..."
            /sbin/route add default gw $GATEWAY br0 && echo "Done." || 
echo "Failed!"
        fi

I've also tried removing the Gateway portion of the script, adding the 
two interfaces in the opposite order, zeroing the two physical 
interfaces IP adresses after building the bridge, but none of that seems 
to have any effect.

Regards,
Mike Boutte

Stephen Hemminger wrote:

>On Wed, 24 Jan 2007 09:30:41 -0800
>Michael Boutte <mboutte@pacbell.net> wrote:
>
>  
>
>>Hello,
>>I am experiencing what may be a unique problem with operating the 
>>bridge. My hardware is custom Freescale MPC875 processor based with one 
>>ethernet (eth0) and one hdlc (hdlc0) WAN port and I am connecting two of 
>>these boards together using the WAN ports over a long distance - 
>>essentially two bridges in series.  They are running Linux 2.6.15 with 
>>bridging enabled in the kernel configuration. When I first power up both 
>>boards the bridge comes up fine and the two outside LANs are connected 
>>as if it were one LAN with a smart long cable in between. brctl works to 
>>set it up and the "showmacs" properly shows all of the MACs on each end.
>>
>>The problem occurs If I disconnect the ethernet cable directly from the 
>>bridge at either end. The console on the disconnected units says "br0: 
>>port 2(eth0) entering disabled state". When I reconnect the cable it 
>>shows "br0: port 2(eth0) entering learning state" plus messages about 
>>network topology change detected. That LAN end no longer has a link to 
>>the other end, yet at the console of the unit disconnected and 
>>reconnected I can ping in either direction to any device in both LAN 
>>segments. Time makes no difference, but if I issue the command "ifconfig 
>>eth0 down" and then back "up" the link is almost immediately restored. 
>>This works either while the cable is disconnected or after it is 
>>reconnected.
>>
>>I compared the effect of a cable disconnect with a standard PC running 
>>Linux and it seems to be identical, that is, ifconfig shows the port as 
>>up even when the cable is disconnected on both. I tried having STP 
>>enabled or disabled, and adding the ports into br0 in the opposite order 
>>with no difference either. Any ideas on why the bridge does not 
>>automatically restore? and especially on how I can make it automatically 
>>restore itself?
>>
>>Thank you for your kind attention.
>>
>>Mike Boutte
>>    
>>
>
>You probably don't want the forwarding delay period (30 seconds)
>that occurs on link transitions. Use:
>	brctl setfd br0 0
>
>
>  
>
