
/* This is a minimalistic configuration file for Xorp
    
   Since the configuration of most routing protocols requires
   knowledge of the IP addresses this configuration file
   only includes support for Multicast forwarding (IGMP and PIM)
   
   In order for this configuration to work you need to have
   at least two network interfaces (eth0 and eth1).

   If you want to see a more detailed configuration sample please
   take look at /usr/share/doc/xorp/examples/config.boot.sample

*/

interfaces {
    restore-original-config-on-shutdown: false
    interface eth0 {
	description: "Ethernet Interface #1"
	disable: false
	default-system-config
    }
    interface eth1 {
	description: "Ethernet Interface #2"
	disable: false
	default-system-config
    }

}

fea {
    unicast-forwarding4 {
	disable: false
	forwarding-entries {
	    retain-on-startup: false
	    retain-on-shutdown:	false
	}
    }
}


plumbing {
    mfea4 {
	disable: false
	interface eth0 {
	    vif eth0 {
		disable: false
	    }
	}
	interface eth1 {
	    vif eth1 {
		disable: false
	    }
	}
	interface register_vif {
	    vif register_vif {
		/* Note: this vif should be always enabled */
		disable: false
	    }
	}
	traceoptions {
	    flag all {
		disable: false
	    }
	}
    }

}

protocols {
    igmp {
	disable: false
	interface eth0 {
	    vif eth0 {
		disable: false
	    }
	} 
	interface eth1 {
	    vif eth1 {
		disable: false
		/* version: 2 */
		/* enable-ip-router-alert-option-check: false */
		/* query-interval: 125 */
		/* query-last-member-interval: 1 */
		/* query-response-interval: 10 */
		/* robust-count: 2 */
	    }
	}
	traceoptions {
	    flag all {
		disable: false
	    }
	}
    }
}

protocols {
    pimsm4 {
	disable: false
	interface eth0 {
	    vif eth0 {
		disable: false
	    }
	} 

	interface eth1 {
	    vif eth1 {
		disable: false
		/* enable-ip-router-alert-option-check: false */
		/* dr-priority: 1 */
		/* hello-period: 30 */
		/* hello-triggered-delay: 5 */
		/* alternative-subnet 10.40.0.0/16 */
	    }
	}

	bootstrap {
	    disable: false
	    cand-bsr {
		scope-zone 224.0.0.0/4 {
		    /* is-scope-zone: false */
		    cand-bsr-by-vif-name: "eth0"
		    /* cand-bsr-by-vif-addr: 10.10.10.10 */
		    /* bsr-priority: 1 */
		    /* hash-mask-len: 30 */
		}
	    }

	    cand-rp {
		group-prefix 224.0.0.0/4 {
		    /* is-scope-zone: false */
		    cand-rp-by-vif-name: "eth0"
		    /* cand-rp-by-vif-addr: 10.10.10.10 */
		    /* rp-priority: 192 */
		    /* rp-holdtime: 150 */
		}
	    }
	}

	switch-to-spt-threshold {
	    /* approx. 1K bytes/s (10Kbps) threshold */
	    disable: false
	    interval: 100
	    bytes: 102400
	}

	traceoptions {
	    flag all {
		disable: false
	    }
	}
    }

}

/*
 * Note: fib2mrib is needed for multicast only if the unicast protocols
 * don't populate the MRIB with multicast-specific routes.
 */
protocols {
    fib2mrib {
	disable: false
    }
}

