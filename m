Message-ID: <4391574.1122387030898.JavaMail.www@wwinf4103>
From: shenry82 <shenry82@voila.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Date: Tue, 26 Jul 2005 16:10:30 +0200 (CEST)
Subject: [Bridge] Timer problem
Reply-To: shenry82@voila.fr
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Bridge@lists.osdl.org

Hi all,

    I try to reduce the time of link break detection for the STP. I want to make a timer who detect a link failure
within a few times instead of waiting max age timeout. The problem is that my timer isn't take in account by the bride and i really don't know why, can someone help me ?
Here's what I've done :

in file br_stp_timer.c :

/* called under bridge lock */
static void br_loss_timer_expired(struct net_bridge_port *p)
{	
	printk(KERN_INFO "il y a perte de connection \n");
	br_timer_set(&p->loss_timer, jiffies); // for the moment I just want my function to be take in account.
}

/* called under bridge lock */
static void br_check_port_timers(struct net_bridge_port *p)
{
	if (br_timer_has_expired(&p->message_age_timer, p->br->max_age)) {
		br_timer_clear(&p->message_age_timer);
		br_message_age_timer_expired(p);
	}

	if (br_timer_has_expired(&p->forward_delay_timer, p->br->forward_delay)) {
		br_timer_clear(&p->forward_delay_timer);
		br_forward_delay_timer_expired(p);
	}

	if (br_timer_has_expired(&p->hold_timer, BR_HOLD_TIME)) {
		br_timer_clear(&p->hold_timer);
		br_hold_timer_expired(p);
	}

	if (br_timer_has_expired(&p->loss_timer, (1*HZ)))  // This condition is never true !?
	{
		printk(KERN_INFO "On a perdu la connection \n");
		br_timer_clear(&p->loss_timer);
		br_loss_timer_expired(p);
	}

}

I also tried to check if my timer is running with br_timer_is_running(&p->loss_timer) but it's also never true.

Thanks for your help,

HENRY Simon

PS : if someone tried to implement RSTP with brctl and succeed I'm interest in ^^
------------------------------------------

Faites un voeu et puis Voila ! www.voila.fr 



